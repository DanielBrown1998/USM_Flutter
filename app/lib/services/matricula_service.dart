import 'package:app/models/matricula.dart';
import 'package:app/models/settings/user_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatriculaService {
  static Future<Matricula> takeMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    var data = await firestore.collection("matriculas").doc(matricula).get();
    if (data.data() == null) {
      throw UserNotFoundException("User with matricula $matricula not found.");
    }
    return Matricula.fromMap(data.data()!);
  }

  static Future<List<Matricula>> takeMatriculas(
      FirebaseFirestore firestore) async {
    List<Matricula> matriculas = [];
    var data = await firestore.collection("matriculas").get();
    for (var item in data.docs) {
      Matricula matricula = Matricula.fromMap(item.data());
      matriculas.add(matricula);
    }
    return matriculas;
  }
}
