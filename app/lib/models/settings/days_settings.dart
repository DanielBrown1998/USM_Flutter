import "package:app/models/days.dart";
import "package:app/services/firebase_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:app/services/days_service.dart';

class DaysSettings with ChangeNotifier {
  late List<Days> days;

  Future<List<Days>> getDays({required String idDisciplina}) async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    days = await DaysService.getDaysOfDisciplineId(firestore, idDisciplina);
    notifyListeners();
    return days;
  }
}
