import "package:app/models/user.dart";
import 'package:flutter/material.dart';

class UserObjects with ChangeNotifier {
  final List<User> users;

  UserObjects({required this.users});

  User getUserByMatricula(String matricula) {
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
