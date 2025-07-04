import 'package:app/models/days.dart';
import 'package:app/services/disciplina_service.dart';
import 'package:app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/models/disciplinas.dart';

class DisciplinasSettings with ChangeNotifier {
  List<Disciplina> disciplinas = [];
  Map<String, List<Days>> days = {};

  void initializeDisciplinas(List<Disciplina> disciplinas) {
    this.disciplinas = disciplinas;
    notifyListeners();
  }

  Future<List<Disciplina>> getDisciplinas() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    disciplinas = await DisciplinaService.getDisciplinas(firestore: firestore);
    notifyListeners();
    return disciplinas;
  }

  Future<List<Days>?> getDays({required Disciplina disciplina}) async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    days[disciplina.id] =
        await DisciplinaService.getDaysOfDisciplineId(firestore, disciplina.id);
    notifyListeners();
    return days[disciplina.id];
  }
}
