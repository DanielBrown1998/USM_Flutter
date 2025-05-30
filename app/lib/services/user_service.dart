import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<List<User>> loadUsers(FirebaseFirestore firestore) async {
    List<User> users = [];
    var userDocs = await firestore.collection("user").get();
    for (var user in userDocs.docs) {
      users.add(User.fromMap(user.data()));
    }
    return users;
  }
}
