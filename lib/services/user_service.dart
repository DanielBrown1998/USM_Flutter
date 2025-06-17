import 'package:app/controllers/user_objects.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  static Future<User> loadUser({required FirebaseFirestore firestore, required String matricula}) async {
    var user = await firestore.collection("user").doc(matricula).get();
    if (user.data() == null) {
      throw UserNotFoundException("User with matricula $matricula not found.");
    }
    return User.fromMap(user.data()!);
  }


  static Future<List<User>> loadUsers(FirebaseFirestore firestore) async {
    List<User> users = [];
    var userDocs = await firestore.collection("user").get();
    for (var user in userDocs.docs) {
      users.add(User.fromMap(user.data()));
    }
    return users;
  }
}
