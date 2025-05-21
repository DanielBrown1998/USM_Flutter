class Disciplinas {
  final int id;
  final String monitor;
  final String nome;
  final String professor;

  Disciplinas(
      {required this.id,
      required this.monitor,
      required this.nome,
      required this.professor});

  Disciplinas.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        monitor = map["monitor"],
        nome = map["nome"],
        professor = map["professor"];

  Map<String, dynamic> toMap() {
    return {"id": id, "monitor": monitor, "nome": nome, "professor": professor};
  }
}
