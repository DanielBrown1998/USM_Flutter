import 'package:app/models/matricula.dart';
import 'package:app/models/settings/user_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatriculaService {
  static Future<Matricula> getDataMatriculaByNumberMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    var snapshot = await firestore.collection("matriculas").doc(matricula).get();
    if (snapshot.data() == null) {
      throw UserNotFoundException("User with matricula $matricula not found.");
    }
    return Matricula.fromMap(snapshot.data()!);
  }

  static Future<List<Matricula>> getAllMatriculas(
      FirebaseFirestore firestore) async {
    List<Matricula> matriculas = [];
    var snapshot = await firestore.collection("matriculas").get();
    for (var item in snapshot.docs) {
      Matricula matricula = Matricula.fromMap(item.data());
      matriculas.add(matricula);
    }
    return matriculas;
  }
}
