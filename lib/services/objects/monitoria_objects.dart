import "package:app/models/data_user.dart";
import "package:app/models/monitoria.dart";
import "package:flutter/material.dart";

class MonitoriaObjects with ChangeNotifier {
  List<Monitoria> monitoria;

  MonitoriaObjects({required this.monitoria});

  List<Monitoria>? getStatusMarcada() {
    List<Monitoria> statusMarcada =
        monitoria.where((element) => element.status == "MARCADA").toList();
    return statusMarcada;
  }

   updateStatusMonitoria({required DataUser? user, required String status}) {
    if (status != "CANCELADA" && status != "PRESENTE" && status != "AUSENTE") {
      throw StatusMOnitoriaException("Status inválido");
    }

    if (user == null) {
      throw StatusMOnitoriaException("Usuário inválido");
    }

    for (Monitoria item in monitoria) {
      if (item.owner == user.owner) {
        item.status = status;
        notifyListeners();
        return item;
      }
    }
  }
}

class StatusMOnitoriaException implements Exception {
  final String message;
  StatusMOnitoriaException(this.message);
  @override
  String toString() {
    return message;
  }
}
