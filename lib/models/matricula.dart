class Matricula{
  final String matricula;
  final String disciplina;
  Matricula({required this.disciplina, required this.matricula});

  Matricula.fromMap(Map<String, dynamic> map)
      : matricula = map["matricula"],
        disciplina = map["disciplina"];
  Map<String, dynamic> toMap() {
    return {"matricula": matricula, "disciplina": disciplina};
  }
}