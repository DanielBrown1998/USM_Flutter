import "package:app/models/matricula.dart";
import "package:app/services/firebase_service.dart";
import "package:app/services/matricula_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MatriculaController with ChangeNotifier {
  List<Matricula> matriculas = [];

  void initializeMatriculas(List<Matricula> matriculas) {
    this.matriculas = matriculas;
    notifyListeners();
  }

  Matricula? getMatricula(String matricula) {
    for (Matricula item in matriculas) {
      if (item.matricula == matricula) {
        return item;
      }
    }
    return null;
  }

  Future<List<Matricula>> getAllMatriculas() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    return await MatriculaService.getAllMatriculas(firestore);
  }
}
