import 'package:app/models/days.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaysService {
  static Future<List<Days>> takeDays(
      FirebaseFirestore firestore, String idDisciplina) async {
    List<Days> days = [];
    var day = await firestore
        .collection("disciplinas")
        .doc(idDisciplina)
        .collection("days")
        .get();
    for (var item in day.docs) {
      String weekday = item.id;
      Map<String, dynamic> hours = item.data();
      Days dataDay = Days(days: weekday, hours: hours);
      days.add(dataDay);
    }
    return days;
  }
}
