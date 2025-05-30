import 'package:app/models/days.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DaysService {
  static Future<List<Days>> takeDays(FirebaseFirestore firestore) async {
    List<Days> days = [];
    var day = await firestore.collection("days").get();
    for (var item in day.docs) {
      String weekday = item.id;
      Map<String, dynamic> hours = item.data();
      print("$weekday $hours");
      Days dataDay = Days(days: weekday, hours: hours);
      days.add(dataDay);
    }
    return days;
  }
}
