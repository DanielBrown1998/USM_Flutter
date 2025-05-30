import 'package:app/models/matricula.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatriculaService {
  static Future<List<Matricula>> takeMatriculas(FirebaseFirestore firestore) async {
    List<Matricula> matriculas = [];
    var data = await firestore.collection("matriculas").get();
    for (var item in data.docs) {
      print(item.id);
      print(item.data()["disciplina"]);
      Matricula matricula =
          Matricula(disciplina: item.data()["disciplina"], matricula: item.id);
      matriculas.add(matricula);
    }
    return matriculas;
  }
}
