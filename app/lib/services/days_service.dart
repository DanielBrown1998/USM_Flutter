import 'package:app/models/days.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaysService {

  //TODO add id na funcao e buscar a apartir dele
  static Future<List<Days>> getDaysOfDisciplineId(
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
