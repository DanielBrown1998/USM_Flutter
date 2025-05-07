import 'package:app/models/data_user.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app/models/objects/monitoria_objects.dart';

class DataUserObjects with ChangeNotifier {
  List<DataUser> dataUser;
  DataUserObjects({required this.dataUser});
  addMonitoria(DataUser user) {
    for (DataUser value in dataUser) {
      if (value == user) {
        print("------------------------------------------------------------");
        print("marcadas: ${value.monitoriasMarcadas}");
        value.monitoriasMarcadas++;
        print("marcadas: ${value.monitoriasMarcadas}");
        print("------------------------------------------------------------");
        notifyListeners();
        break;
      }
    }
  }

  updateDataUser(DataUser user, String status) {
    for (DataUser value in dataUser) {
      if (value == user) {
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
  }

  DataUser getUser(User user) {
    for (DataUser value in dataUser) {
      if (value.owner == user) {
        return value;
      }
    }
    throw DataUserNotFoundException(
        "User with matricula ${user.userName} not found.");
  }
}

class DataUserNotFoundException implements Exception {
  final String message;
  DataUserNotFoundException(this.message);
  @override
  String toString() {
    return message;
  }
}
