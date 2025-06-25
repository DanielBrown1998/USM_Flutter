import "package:app/models/matricula.dart";
import "package:app/services/firebase_service.dart";
import "package:app/services/matricula_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MatriculaObjects with ChangeNotifier {
  List<Matricula> matriculas = [];

  void initializeMatriculas(List<Matricula> matriculas) {
    this.matriculas = matriculas;
    notifyListeners();
  }

  Future<List<Matricula>> getMatriculas() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    return await MatriculaService.takeMatriculas(firestore);
  }
}
