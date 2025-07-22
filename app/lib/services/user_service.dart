import 'package:app/controllers/user_controllers.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<User> getUserByMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    List<User> users = await loadUsers(firestore);
    for (User user in users) {
      if (user.userName == matricula) {
        return user;
      }
    }
    throw UserNotFoundException("User with matricula $matricula not found.");
  }

  static Future<User> getUserByUid(
      {required FirebaseFirestore firestore, required String uid}) async {
    var snapshot = await firestore.collection("user").doc(uid).get();
    if (snapshot.data() == null) {
      throw UserNotFoundException("User with uid: $uid not found.");
    }
    return User.fromMap(snapshot.data()!);
  }

  static setUser(
      {required FirebaseFirestore firestore, required User user}) async {
    await firestore.collection("user").doc(user.uid).set(user.toMap());
  }

  static Future<User> updateUser(
      {required FirebaseFirestore firestore, required User user}) async {
    await firestore.collection("user").doc(user.uid).update(user.toMap());
    return user;
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
