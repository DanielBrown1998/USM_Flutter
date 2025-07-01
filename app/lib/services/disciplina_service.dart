import "package:app/models/days.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:app/models/disciplinas.dart";

class DisciplinaService {
  static String collection = "disciplinas";

  static Future<List<Disciplinas>> getDisciplinas(
      {required FirebaseFirestore firestore}) async {
    List<Disciplinas> disciplinas = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(collection).get();
    for (var item in snapshot.docs) {
      disciplinas.add(Disciplinas.fromMap(item.data()));
    }
    return disciplinas;
  }

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
