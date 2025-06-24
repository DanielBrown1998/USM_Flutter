import "package:cloud_firestore/cloud_firestore.dart";
import "package:app/models/disciplinas.dart";

class DisciplinaService {
  static String collection = "disciplinas";

  static Future<List<Disciplinas>> getDisciplinasIDs(
      {required FirebaseFirestore firestore}) async {
    List<Disciplinas> disciplinas = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(collection).get();
    for (var item in snapshot.docs) {
      print(item.data());
      disciplinas.add(Disciplinas.fromMap(item.data()));
    }
    return disciplinas;
  }
}
