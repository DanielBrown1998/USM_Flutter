import "package:app/models/matricula.dart";
import "package:app/services/firebase_service.dart";
import "package:app/services/matricula_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MatriculaObjects with ChangeNotifier {
  final List<Matricula> matriculas;
  MatriculaObjects({required this.matriculas});

  Future<List<Matricula>> getMatriculas() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    return await MatriculaService.takeMatriculas(firestore);
  }
}
