import 'package:app/models/data_user.dart';
// import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app/models/objects/monitoria_objects.dart';

class DataUserObjects with ChangeNotifier {
  DataUser? dataUser;

  DataUserObjects({this.dataUser});

  addMonitoria() {
    DataUser? value = dataUser;
    if (value != null) {
      print("------------------------------------------------------------");
      print("marcadas antes: ${value.monitoriasMarcadas}");
      value.monitoriasMarcadas++;
      print("marcadas atualizada: ${value.monitoriasMarcadas}");
      print("------------------------------------------------------------");
      notifyListeners();
    }
  }

  updateDataUser(DataUser user, String status) {
    DataUser? value = dataUser;
    if (value != null && value == user) {
      print("------------------------------------------------------------");
      print("marcadas: ${value.monitoriasMarcadas}");
      print("ausentes: ${value.monitoriasAusentes}");
      print("presentes: ${value.monitoriasPresentes}");
      print("------------------------------------------------------------");

      if (status == "PRESENTE") {
        value.monitoriasPresentes++;
      } else if (status == "AUSENTE") {
        value.monitoriasAusentes++;
      } else if (status == "CANCELADA") {
        value.monitoriasCanceladas++;
      } else {
        throw StatusMOnitoriaException("Status inválido");
      }
      print("------------------------------------------------------------");
      print("marcadas: ${value.monitoriasMarcadas}");
      print("ausentes: ${value.monitoriasAusentes}");
      print("presentes: ${value.monitoriasPresentes}");
      print("------------------------------------------------------------");

      notifyListeners();
      return user;
    }
  }

  // DataUser getUser(User user) {

  //   for (DataUser value in dataUser) {
  //     if (value.owner.userName == user.userName) {
  //       return value;
  //     }
  //   }
  //   throw DataUserNotFoundException(
  //       "User with matricula ${user.userName} not found.");
  // }
}

class DataUserNotFoundException implements Exception {
  final String message;
  DataUserNotFoundException(this.message);
  @override
  String toString() {
    return message;
  }
}
