import 'package:app/models/disciplinas.dart';
import 'package:app/models/matricula.dart';
import "package:app/models/user.dart";
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  User? user;
  Matricula? matricula;

  UserController({this.user});

  bool removeDisciplinaThisUser(Disciplina disciplina) {
    if (user!.disciplinas.contains(disciplina)) {
      return user!.disciplinas.remove(disciplina);
    }
    return false;
  }

  // User getUserByMatricula(String matricula) {
  //   for (User user in users) {
  //     if (user.userName == matricula) {
  //       return user;
  //     }
  //   }
  //   throw UserNotFoundException("$matricula nao encontrada");
  // }
}

class UserNotFoundException implements Exception {
  final String message;
  UserNotFoundException(this.message);
  @override
  String toString() {
    return message;
  }
}
