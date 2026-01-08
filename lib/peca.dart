import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart'; // Precisaremos instalar este pacote

part 'peca.g.dart';

@collection
class Peca {
  Id id = Isar.autoIncrement; // ID interno do Isar (obrigatório)

  @Index(unique: true, replace: true)
  late String cid; // Seu ID aleatório (ex: a0eebc9)

  late String nome;
  double? temperatura;
  double? vibracao;
}