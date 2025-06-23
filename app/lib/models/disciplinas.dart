class Disciplinas {
  final String id;
  final Map<String, dynamic> monitor;
  final String nome;

  Disciplinas({required this.id, required this.monitor, required this.nome});

  Disciplinas.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        monitor = map["monitor"],
        nome = map["nome"];

  Map<String, dynamic> toMap() {
    return {"id": id, "monitor": monitor, "nome": nome};
  }
}
