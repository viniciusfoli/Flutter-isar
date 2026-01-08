import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'peca.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// salvar no servidor
Future<void> enviarParaServidor(Peca pecaLocal) async {
  // O endereço da sua API C#
  final url = Uri.parse('https://localhost:7265/AR');

  // Convertendo a Peça do Isar para o formato que a API aceita
  // No main.dart, dentro de enviarParaServidor
  final corpoJson = jsonEncode({
    'id': pecaLocal.cid, // Certifique-se que o nome da chave é 'id'
    'nome': pecaLocal.nome,
    'temperatura': pecaLocal.temperatura,
  });

  try {
    final resposta = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: corpoJson,
    );

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

  // 1. POST: Cria com UUID aleatório
  Future<void> criarPeca() async {
    final uuid = const Uuid().v4();
    final nova = Peca()
      ..cid = uuid
      ..nome = _nomeController.text
      ..temperatura = double.tryParse(_tempController.text) ?? 0.0;

    // Salva localmente primeiro (garante o dado offline)
    await widget.isar.writeTxn(() => widget.isar.pecas.put(nova));
    print("POST Local: Criada peça com ID: $uuid");

    // ENVIA PARA A API (Sincronização imediata se houver internet)
    await enviarParaServidor(nova); 
  }

  // 2. GET: Lista tudo no console (para você copiar o ID)
  Future<void> listarPecas() async {
    final pecas = await widget.isar.pecas.where().findAll();
    print("\n--- LISTA DE PEÇAS NO BANCO ---");
    for (var p in pecas) {
      print("ID ÚNICO: ${p.cid} | Nome: ${p.nome} | Temp: ${p.temperatura}°C");
    }
  }

  // 3. PUT: Atualiza a peça que tiver o ID colado no campo
  Future<void> atualizarPorId() async {
    final pecaExistente = await widget.isar.pecas.filter().cidEqualTo(_cidController.text).findFirst();

    if (pecaExistente != null) {
      pecaExistente.nome = _nomeController.text;
      pecaExistente.temperatura = double.tryParse(_tempController.text) ?? 0.0;
      await widget.isar.writeTxn(() => widget.isar.pecas.put(pecaExistente));
      print("PUT: Peça ${pecaExistente.cid} atualizada!");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inspeção Offshore - Gestão por UUID")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: "Nome da Peça")),
            TextField(controller: _tempController, decoration: const InputDecoration(labelText: "Temperatura (°C)")),
            const SizedBox(height: 10),
            TextField(
              controller: _cidController, 
              decoration: const InputDecoration(labelText: "COLAR ID (UUID) PARA EDITAR/DELETAR", labelStyle: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 20),
            // Botões de Ação
            Wrap(spacing: 10, runSpacing: 10, children: [
              ElevatedButton(onPressed: criarPeca, child: const Text("Gravar Novo (POST)")),
              ElevatedButton(onPressed: listarPecas, child: const Text("Listar IDs (GET)")),
              ElevatedButton(onPressed: atualizarPorId, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100), child: const Text("Atualizar ID (PUT)")),
              ElevatedButton(onPressed: deletarPorId, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100), child: const Text("Deletar ID (DELETE)")),
            ]),
          ],
        ),
      ),
    );
  }
}