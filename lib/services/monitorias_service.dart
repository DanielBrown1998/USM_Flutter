import "package:app/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:app/models/monitoria.dart";

class MonitoriasService {
  static Future<List<Monitoria>> loadMonitorias(
      FirebaseFirestore firestore) async {
    List<Monitoria> mon = [];
    var monitorias = await firestore.collection("monitorias").get();
    for (var item in monitorias.docs) {
      var itemMap = item.data();
      var user = await firestore.collection("user").doc(itemMap["user"]).get();
      if (user.data() == null) {
        continue;
      }
      mon.add(Monitoria(
          date: itemMap["date"].toDate(),
          owner: User.fromMap(user.data()!),
          status: itemMap["status"].toString().toUpperCase()));
    }
    return mon;
  }
}
