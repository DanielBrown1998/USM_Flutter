import "package:app/models/user.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserObjects with ChangeNotifier {
  final FirebaseFirestore firestore;
  List<User> users = [];

  UserObjects({required this.firestore});
  void _loadUsers() async {
    var userDocs = await firestore.collection("user").get();
    for (var user in userDocs.docs) {
      users.add(User.fromMap(user.data()));
    }
  }

  User getUserByMatricula(String matricula) {
    _loadUsers();
    for (User user in users) {
      if (user.userName == matricula) {
        return user;
      }
    }
    throw UserNotFoundException("$matricula nao encontrada");
  }
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);
  @override
  String toString() {
    return message;
  }
}
