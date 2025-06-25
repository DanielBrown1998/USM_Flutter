import 'package:app/services/disciplina_service.dart';
import 'package:app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/models/disciplinas.dart';

class DisciplinasObjects with ChangeNotifier {
  List<Disciplinas> disciplinas = [];

  void initializeDisciplinas(List<Disciplinas> disciplinas) {
    this.disciplinas = disciplinas;
    notifyListeners();
  }

  Future<List<Disciplinas>> getDisciplinas() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    disciplinas =
        await DisciplinaService.getDisciplinasIDs(firestore: firestore);
    notifyListeners();
    return disciplinas;
  }
}
