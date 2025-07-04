class Disciplina {
  final String id;
  final String monitor;
  final String nome;
  final String campus;

  Disciplina(
      {required this.id,
      required this.monitor,
      required this.nome,
      required this.campus});

  Disciplina.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        monitor = map["monitor"],
        nome = map["nome"],
        campus = map["campus"];

  Map<String, dynamic> toMap() {
    return {"id": id, "monitor": monitor, "nome": nome, "campus": campus};
  }

  @override
  String toString() {
    return nome;
  }
}
