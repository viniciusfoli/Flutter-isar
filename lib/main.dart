import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'peca.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// salvar no servidor
Future<void> enviarParaServidor(Peca pecaLocal, {bool isUpdate = false}) async {
  // O endereço da sua API C#
  final url = isUpdate 
      ? Uri.parse('https://localhost:7265/AR/${pecaLocal.cid}') 
      : Uri.parse('https://localhost:7265/AR');

  // Convertendo a Peça do Isar para o formato que a API aceita
  // No main.dart, dentro de enviarParaServidor
  final corpoJson = jsonEncode({
    'id': pecaLocal.cid, // Certifique-se que o nome da chave é 'id'
    'nome': pecaLocal.nome,
    'temperatura': pecaLocal.temperatura,
    'vibracao': pecaLocal.vibracao,
    'instrucao': pecaLocal.instrucao,
    'historicoJson': pecaLocal.historicoJson,
  });

  try {
    final resposta = isUpdate 
        ? await http.put(url, headers: {'Content-Type': 'application/json'}, body: corpoJson)
        : await http.post(url, headers: {'Content-Type': 'application/json'}, body: corpoJson);

    if (resposta.statusCode == 200 || resposta.statusCode == 201) {
      print("Sincronizado: ${pecaLocal.nome} enviado ao servidor!");
    } else {
      print("Erro: API retornou status ${resposta.statusCode}");
    }
  } catch (e) {
    // Isso acontecerá se a API .NET não estiver rodando (Play pressionado)
    print("Servidor Offline: Dado guardado apenas no Isar local.");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([PecaSchema], directory: dir.path);
  
  
  runApp(MaterialApp(home: TelaInspecao(isar: isar)));
}

class TelaInspecao extends StatefulWidget {
  final Isar isar;
  TelaInspecao({required this.isar});

  @override
  State<TelaInspecao> createState() => _TelaInspecaoState();
}

class _TelaInspecaoState extends State<TelaInspecao> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _cidController = TextEditingController(); // Campo para o ID longo
  final TextEditingController _vibracaoController = TextEditingController();
  // Adicione junto aos outros controladores no topo da classe
  final TextEditingController _instrucaoController = TextEditingController();

  // 1. POST: Cria com UUID aleatório
  Future<void> criarPeca() async {
    final uuid = const Uuid().v4();
    final nova = Peca()
      ..cid = uuid
      ..nome = _nomeController.text
      ..temperatura = double.tryParse(_tempController.text) ?? 0.0
      ..vibracao = double.tryParse(_vibracaoController.text) ?? 0.0
      ..instrucao = _instrucaoController.text
      ..historicoJson = '[]';// Inicia com lista vazia

    // Salva localmente primeiro (garante o dado offline)
    await widget.isar.writeTxn(() => widget.isar.pecas.put(nova));
    print("POST Local: Criada peça com ID: $uuid");

    // ENVIA PARA A API (Sincronização imediata se houver internet)
    _instrucaoController.clear();
    await enviarParaServidor(nova); 
  }

  // 2. GET: Lista tudo no console (para você copiar o ID)
  Future<void> listarPecas() async {
    final pecas = await widget.isar.pecas.where().findAll();
    print("\n--- LISTA DE PEÇAS NO BANCO ---");
    for (var p in pecas) {
      print("ID ÚNICO: ${p.cid} | Nome: ${p.nome} | Temp: ${p.temperatura}°C | Vibração: ${p.vibracao}Hz | Instrução: ${p.instrucao}");
    }
  }

  // 3. PUT: Atualiza a peça que tiver o ID colado no campo
  Future<void> atualizarPorId() async {
    final pecaExistente = await widget.isar.pecas.filter().cidEqualTo(_cidController.text).findFirst();

    if (pecaExistente != null) {
      pecaExistente.nome = _nomeController.text;
      pecaExistente.temperatura = double.tryParse(_tempController.text) ?? 0.0;
      pecaExistente.vibracao = double.tryParse(_vibracaoController.text) ?? 0.0;
      await widget.isar.writeTxn(() => widget.isar.pecas.put(pecaExistente));
      print("PUT: Peça ${pecaExistente.cid} atualizada!");
      await enviarParaServidor(pecaExistente, isUpdate: true);
    } else {
      print("ERRO: ID não encontrado no banco.");
    }
  }

  // 4. DELETE: Remove apenas a peça do ID colado
  Future<void> deletarPorId() async {
    final peca = await widget.isar.pecas.filter().cidEqualTo(_cidController.text).findFirst();
    if (peca != null) {
      await widget.isar.writeTxn(() => widget.isar.pecas.delete(peca.id));
      print("DELETE: Peça removida com sucesso.");
    }
  }

  Future<void> limparBancoGeral() async {
    await widget.isar.writeTxn(() => widget.isar.pecas.clear());
    print("Banco de dados limpo com sucesso!");
    setState(() {}); // Atualiza a tela
  }

  // Função para salvar um novo comentário na peça
  Future<void> salvarNovoComentario(Peca peca, String texto) async {
    // 1. Transforma o texto do banco em uma lista real do Dart
    List<dynamic> lista = jsonDecode(peca.historicoJson);

    // 2. Cria o novo objeto de comentário
    Map<String, dynamic> novoItem = {
      'texto': texto,
      'data': DateTime.now().toString().substring(0, 16), // Data legível
    };

    // 3. Insere no topo da lista (índice 0)
    lista.insert(0, novoItem);

    // 4. Transforma a lista de volta em texto JSON
    peca.historicoJson = jsonEncode(lista);

    // 5. Salva a atualização no Isar
    await widget.isar.writeTxn(() => widget.isar.pecas.put(peca));
    await enviarParaServidor(peca, isUpdate: true);
  }

  void mostrarDialogComentario(Peca peca) {
    final TextEditingController _comentarioController = TextEditingController();
    
    // Decodifica o histórico para exibir na lista
    List<dynamic> historico = jsonDecode(peca.historicoJson);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Histórico de ${peca.nome}"),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Lista de comentários existentes
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: historico.length,
                    itemBuilder: (context, index) {
                      final item = historico[index];
                      return ListTile(
                        title: Text(item['texto']),
                        subtitle: Text(item['data']),
                        leading: const Icon(Icons.comment, size: 20),
                      );
                    },
                  ),
                ),
                const Divider(),
                TextField(
                  controller: _comentarioController,
                  decoration: const InputDecoration(hintText: "Adicionar novo comentário..."),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Fechar")),
            ElevatedButton(
              onPressed: () async {
                if (_comentarioController.text.isNotEmpty) {
                  await salvarNovoComentario(peca, _comentarioController.text);
                  Navigator.pop(context);
                  // Reabre para atualizar a lista visualmente
                  final pecaAtualizada = await widget.isar.pecas.filter().cidEqualTo(peca.cid).findFirst();
                  if (pecaAtualizada != null) mostrarDialogComentario(pecaAtualizada);
                }
              },
              child: const Text("Postar"),
            ),
          ],
        );
      },
    );
  }

  Future<void> listarHistoricoPorId() async {
    // 1. Busca a peça pelo CID do campo azul
    final peca = await widget.isar.pecas.filter().cidEqualTo(_cidController.text).findFirst();

    if (peca != null) {
      // 2. Decodifica o JSON
      List<dynamic> historico = jsonDecode(peca.historicoJson);
      
      print("\n--- HISTÓRICO DA PEÇA: ${peca.nome} ---");
      if (historico.isEmpty) {
        print("Nenhum comentário encontrado.");
      } else {
        // 3. Lista do primeiro ao último (ou vice-versa, dependendo de como salvou)
        for (var i = 0; i < historico.length; i++) {
          final item = historico[i];
          print("${i + 1}. [${item['data']}] - ${item['texto']}");
        }
      }
      print("---------------------------------------");
    } else {
      print("ERRO: ID não encontrado para listar histórico.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inspeção Offshore - Gestão por UUID")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [ // Início da lista de componentes
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: "Nome da Peça")),
            TextField(controller: _tempController, decoration: const InputDecoration(labelText: "Temperatura (°C)")),
            TextField(controller: _vibracaoController, decoration: const InputDecoration(labelText: "Vibração (Hz)")),
            
            const SizedBox(height: 10),
            
            // --- NOVO CAMPO DE INSTRUÇÕES AQUI ---
            TextField(
              controller: _instrucaoController,
              maxLines: 5, 
              decoration: const InputDecoration(
                labelText: "Instruções Técnicas",
                hintText: "Digite aqui as instruções ou observações cad...",
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 10),

            TextField(
              controller: _cidController, 
              decoration: const InputDecoration(labelText: "COLAR ID (UUID) PARA EDITAR/DELETAR", labelStyle: TextStyle(color: Colors.blue)),
            ),
            
            const SizedBox(height: 20),
            
            Wrap(spacing: 10, runSpacing: 10, children: [
              ElevatedButton(onPressed: criarPeca, child: const Text("Gravar Novo (POST)")),
              ElevatedButton(onPressed: listarPecas, child: const Text("Listar IDs (GET)")),
              ElevatedButton(onPressed: atualizarPorId, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100), child: const Text("Atualizar ID (PUT)")),
              ElevatedButton(onPressed: deletarPorId, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100), child: const Text("Deletar ID (DELETE)")),
              ElevatedButton(
                onPressed: () async {
                  // 1. Busca a peça pelo CID digitado no campo azul
                  final peca = await widget.isar.pecas.filter().cidEqualTo(_cidController.text).findFirst();

                  if (peca != null) {
                    // 2. Se achou a peça, abre o pop-up que criamos
                    mostrarDialogComentario(peca);
                  } else {
                    print("ERRO: Digite um ID válido para comentar.");
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
                child: const Text("Comentar no ID"),
              ),
              ElevatedButton(
                onPressed: listarHistoricoPorId,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade100),
                child: const Text("Ver Histórico (CID)"),
              ),
              ElevatedButton(
                onPressed: limparBancoGeral,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                child: const Text("Limpar Tudo"),
              ),
            ]),
          ], // Fim da lista de componentes (o colchete deve fechar aqui!)
        ),
      ),
    );
  }
}