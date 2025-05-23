import "package:app/models/matricula.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:app/services/firebase_service.dart" as firebase;

class MatriculaObjects with ChangeNotifier {
  List<Matricula> matriculas = [];

  MatriculaObjects() {
    _takeMatriculas();
  }

  _takeMatriculas() async {
    FirebaseFirestore firestore =
        await firebase.FirebaseService.initializeFirebase();
    var data = await firestore.collection("matriculas").get();
    for (var item in data.docs) {
      print(item.id);
      print(item.data()["disciplina"]);
      Matricula matricula =
          Matricula(disciplina: item.data()["disciplina"], matricula: item.id);
      matriculas.add(matricula);
    }
    notifyListeners();
  }
}

