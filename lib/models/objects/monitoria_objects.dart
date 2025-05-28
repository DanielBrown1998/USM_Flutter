import "package:app/models/data_user.dart";
import "package:app/models/monitoria.dart";
import "package:app/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MonitoriaObjects with ChangeNotifier {
  List<Monitoria> monitoria = [];
  final FirebaseFirestore firestore;

  MonitoriaObjects({required this.firestore});

  Future<List<Monitoria>> loadMonitorias() async {
    if (monitoria.isNotEmpty) return monitoria;
    var monitorias = await firestore.collection("monitorias").get();
    for (var item in monitorias.docs) {
      var itemMap = item.data();
      var user = await firestore.collection("user").doc(itemMap["user"]).get();
      if (user.data() == null) {
        continue;
      }
      monitoria.add(Monitoria(
          date: itemMap["date"].toDate(),
          owner: User.fromMap(user.data()!),
          status: itemMap["status"].toString().toUpperCase()));
    }
    return monitoria;
  }

  List<Monitoria> getMonitoriasbyDate(
      {required DateTime date, required int limit}) {
    List<Monitoria> monitoriasByDate = monitoria
        .where((element) =>
            element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year)
        .toList();
    print("------------------------------------------------------------");
    monitoriasByDate.forEach((element) => print(element.owner.firstName));
    print("------------------------------------------------------------");

    if (monitoriasByDate.length >= limit) {
      throw MonitoriaExceedException(
          "Limite de monitorias por dia excedido. Limite: $limit");
    }
    return monitoriasByDate;
  }

  bool getMonitoriasbyUser(
      {required List<Monitoria> monitoriaList,
      required DateTime date,
      required User user}) {
    bool monitoriasByDate = monitoriaList
        .where((element) => element.owner == user && element.date == date)
        .isEmpty;
    print("------------------------------------------------------------");
    print(monitoriasByDate);
    print("------------------------------------------------------------");
    if (monitoriasByDate == false) {
      throw UserAlreadyMarkDateException(
          "${user.firstName} ja marcoru monitoria para esse dia ${date.day}/${date.month}/${date.year}");
    }
    return monitoriasByDate;
  }

  bool addMonitoria({required Monitoria mon}) {
    List<Monitoria> mons = getMonitoriasbyDate(date: mon.date, limit: 10);
    bool mark = getMonitoriasbyUser(
        monitoriaList: mons, date: mon.date, user: mon.owner);
    if (mark) {
      print("------------------------------------------------------------");
      print(mon.date);
      print(mon.owner.firstName);
      print(mon.status);
      print("------------------------------------------------------------");
      monitoria.add(mon);
      print("------------------------------------------------------------");
      monitoria.forEach((element) => print(element.date));
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  List<Monitoria>? _getStatusMarcada() {
    List<Monitoria> statusMarcada =
        monitoria.where((element) => element.status == "MARCADA").toList();
    print(statusMarcada);
    return statusMarcada;
  }

  updateStatusMonitoria(
      {required DataUser? user,
      required DateTime date,
      required String status}) {
    if (status != "CANCELADA" && status != "PRESENTE" && status != "AUSENTE") {
      throw StatusMOnitoriaException("Status inválido");
    }

    if (user == null) {
      throw StatusMOnitoriaException("Usuário inválido");
    }

    print("------------------------------------------------------------");
    monitoria.forEach((element) => print(element.date));

    for (Monitoria item in monitoria) {
      if (item.owner == user.owner && item.date == date) {
        print("------------------------------------------------------------");
        print("antes: ${item.status}");
        item.status = status;
        print("depois: ${item.status}");
        print("------------------------------------------------------------");
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
