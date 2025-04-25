import "package:app/models/user.dart";
import 'package:flutter/material.dart';

class UserObjects with ChangeNotifier{
  List<User> user;

  UserObjects({required this.user});

  User getUserByMatricula(String matricula){
    for (User value in user){
      if (value.userName == matricula){
        return value;
      }
    }
    throw UserNotFoundException("User with matricula $matricula not found.");
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