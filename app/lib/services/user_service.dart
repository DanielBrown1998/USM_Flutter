import 'package:app/models/settings/user_settings.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  static Future<User> loadUser({required FirebaseFirestore firestore, required String matricula}) async {
    var snapshot = await firestore.collection("user").doc(matricula).get();
    if (snapshot.data() == null) {
      throw UserNotFoundException("User with matricula $matricula not found.");
    }
    return User.fromMap(snapshot.data()!);
  }


  static Future<List<User>> loadUsers(FirebaseFirestore firestore) async {
    List<User> users = [];
    var snapshot = await firestore.collection("user").get();
    for (var user in snapshot.docs) {
      users.add(User.fromMap(user.data()));
    }
    return users;
  }
}
