// import "package:app/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:app/models/monitoria.dart";

class MonitoriasService {
  static Future<void> saveMonitoria(
      {required FirebaseFirestore firestore,
      required Monitoria monitoria}) async {
    await firestore
        .collection("monitorias")
        .doc(monitoria.id)
        .set(monitoria.toMap());
  }

  static Future<List<Monitoria>> loadMonitorias(
      FirebaseFirestore firestore) async {
    List<Monitoria> mon = [];
    var monitorias = await firestore.collection("monitorias").get();
    for (var item in monitorias.docs) {
      print(item.data());
      mon.add(Monitoria.fromMap(item.data()));
    }
    return mon;
  }
}
