class Disciplina {
  final String id;
  final String monitor;
  final String nome;
  final String campus;
  final int? limitByDay;

  Disciplina(
      {required this.id,
      required this.monitor,
      required this.nome,
      required this.campus,
      required this.limitByDay});

  Disciplina.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        monitor = map["monitor"],
        nome = map["nome"],
        campus = map["campus"],
        limitByDay = map["limitByDay"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "monitor": monitor,
      "nome": nome,
      "campus": campus,
      "limitByDay": limitByDay
    };
  }

  @override
  String toString() {
    return nome;
  }
}
