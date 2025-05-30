import 'package:app/models/data_user.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUserService {
  static Future<List<DataUser>> loadDataUser(FirebaseFirestore firestore) async {
    List<DataUser> dataUser = [];
    var data = await firestore.collection("dataUser").get();
    for (var item in data.docs) {
      var user = await firestore.collection("user").doc(item.id).get();
      if (user.data() == null) {
        continue;
      }
      Map<String, dynamic> itemData = item.data();
      dataUser.add(DataUser(
          owner: User.fromMap(user.data()!),
          phone: itemData["phone"],
          monitoriasAusentes: itemData["monitoriasAusentes"],
          monitoriasCanceladas: itemData["monitoriasCanceladas"],
          monitoriasMarcadas: itemData["monitoriasMarcadas"],
          monitoriasPresentes: itemData["monitoriasPresentes"]));
    }
    return dataUser;
  }
}
