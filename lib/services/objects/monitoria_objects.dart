import "package:app/models/data_user.dart";
import "package:app/models/monitoria.dart";
import "package:flutter/material.dart";

class MonitoriaObjects with ChangeNotifier {
  List<Monitoria> monitoria;

  MonitoriaObjects({required this.monitoria});

  List<Monitoria> _getMonitoriasbyDate(
      {required DateTime date, required int limit}) {
    List<Monitoria> monitoriasByDate = monitoria
        .where((element) =>
            element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year)
        .toList();
    if (monitoriasByDate.length >= limit) {
      throw MonitoriaExceedException(
          "Limite de monitorias por dia excedido. Limite: $limit");
    }
    return monitoriasByDate;
  }

  bool _getMonitoriasbyUser(
      {required List<Monitoria> monitoriaList, required DateTime date, required DataUser dataUser}) {
    bool monitoriasByDate = monitoriaList
        .where((element) => element.owner == dataUser.owner)
        .isEmpty;
    if (monitoriasByDate == false) {
      throw UserAlreadyMarkDateException(
          "${dataUser.owner.firstName} ja marcoru monitoria para esse dia ${date.day}/${date.month}/${date.year}");
    }
    return monitoriasByDate;
  }

  bool addMonitoria({required Monitoria mon, required DataUser dataUser}) {
    List<Monitoria> mons = _getMonitoriasbyDate(date: mon.date, limit: 10);
    bool mark = _getMonitoriasbyUser(monitoriaList: mons, date: mon.date, dataUser: dataUser);
    if (mark) {
      monitoria.add(mon);
      notifyListeners();
      return true;
    }
    return false;
  }

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

class UserAlreadyMarkDateException implements Exception {
  final String message;
  UserAlreadyMarkDateException(this.message);
  @override
  String toString() {
    return message;
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

class MonitoriaExceedException implements Exception {
  final String message;
  MonitoriaExceedException(this.message);
  @override
  String toString() {
    return message;
  }
}
