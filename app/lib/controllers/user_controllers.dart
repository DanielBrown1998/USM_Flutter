import 'package:app/models/disciplinas.dart';
import 'package:app/models/matricula.dart';
import "package:app/models/user.dart";
import 'package:app/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth_firebase;


class UserController with ChangeNotifier {
  User? user;
  Matricula? matricula;
  final AuthService authService;
  UserController({this.user, AuthService? authService})
      : authService = authService ?? AuthService();

  Future<bool> login(FirebaseFirestore firestore,
      {required String email, required String password}) async {
    auth_firebase.User? auth =
        await authService.login(email: email, password: password);
    if (auth == null) return false;
    user = await UserService.getUserByUid(firestore: firestore, uid: auth.uid);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await authService.logout();
    user = null;
    matricula = null;
    notifyListeners();
  }

  Future<User?> register(FirebaseFirestore firestore,
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phone,
      required Matricula matricula,
      isStaff = false,
      isSuperUser = false,
      isActive = true}) async {
    auth_firebase.User? auth = await authService.register(
        name: firstName + lastName, email: email, password: password);

    if (auth == null) return null;
    user = User(
        uid: auth.uid,
        campus: matricula.campus,
        disciplinas: matricula.disciplinas,
        email: email,
        firstName: firstName,
        phone: phone,
        lastName: lastName,
        userName: matricula.matricula,
        dateJoined: auth.metadata.creationTime,
        isActive: isActive,
        isStaff: isStaff,
        isSuperUser: isSuperUser,
        lastLogin: auth.metadata.lastSignInTime);
    notifyListeners();
    await UserService.setUser(firestore: firestore, user: user!);
    return user;
  }

  bool checkDisciplinasThisUserInMatricula(FirebaseFirestore firestore) {
    if (user == null || matricula == null) {
      throw UserControllerException('user or matricula not implemented yet');
    }
    if (user!.disciplinas == matricula!.disciplinas) return true;
    user!.disciplinas = matricula!.disciplinas;
    updateUser(firestore: firestore, user: user!);
    return true;
  }

  Future<bool> removeDisciplinaThisUser(
      {required FirebaseFirestore firestore,
      required Disciplina disciplina}) async {
    if (user!.disciplinas.contains(disciplina)) {
      user!.disciplinas.remove(disciplina);
      updateUser(firestore: firestore, user: user!);
    }
    return false;
  }

  Future<User> updateUser(
      {required FirebaseFirestore firestore, required User user}) async {
    user = await UserService.updateUser(firestore: firestore, user: user);
    notifyListeners();
    return user;
  }

  Future<User?> getUserByMatriculaForLogin(
      {required FirebaseFirestore firestore, required String matricula}) async {
    user = await UserService.getUserByMatricula(
        firestore: firestore, matricula: matricula);
    notifyListeners();
    return user;
  }

  Future<User?> getUserByMatricula(
      {required FirebaseFirestore firestore, required String matricula}) async {
    if (!(user!.isStaff || user!.isSuperUser)) return null;
    User newUser = await UserService.getUserByMatricula(
        firestore: firestore, matricula: matricula);
    return newUser;
  }
}

class UserControllerException {
  final String message;
  UserControllerException(this.message);
  @override
  String toString() {
    return message;
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
