import 'package:app/models/data_user.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUserService {
  static Future<DataUser> loadDataUser(
      {required FirebaseFirestore firestore, required User user}) async {
    var data = await firestore.collection("dataUser").doc(user.userName.toString()).get();
    if (data.data() == null) {
      return DataUser(
        owner: user,
        phone: "",
      );
    } else {
      return DataUser.fromMap(data.data()!);
    }
  }

  static Future<List<DataUser>> loadDataUsers(
      FirebaseFirestore firestore) async {
    List<DataUser> dataUsers = [];
    var data = await firestore.collection("dataUser").get();
    for (var item in data.docs) {
      // var user = await firestore.collection("user").doc(item.id).get();
      // if (user.data() == null) {
      //   continue;
      // }
      Map<String, dynamic> itemData = item.data();
      dataUsers.add(DataUser.fromMap(itemData));
    }
    return dataUsers;
  }
}
