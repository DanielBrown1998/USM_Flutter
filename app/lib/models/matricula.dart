
import 'package:app/models/disciplinas.dart';

class Matricula {
  final String matricula;
  final List<Disciplinas> disciplina;
  final String campus;
  Matricula(
      {required this.disciplina,
      required this.matricula,
      required this.campus});

  Matricula.fromMap(Map<String, dynamic> map)
      : matricula = map["matricula"],
        disciplina = List.generate(map["disciplinas"].length,
            (index) => Disciplinas.fromMap(map["disciplinas"][index])),
        campus = map["campus"];
  Map<String, dynamic> toMap() {
    return {
      "matricula": matricula,
      "disciplinas": disciplina.map((Disciplinas value) => value.toMap()),
      "campus": campus
    };
  }
}
