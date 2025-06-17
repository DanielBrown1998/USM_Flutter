import "package:app/models/monitoria.dart";
import "package:app/services/firebase_service.dart";
import "package:app/services/monitorias_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class MonitoriaObjects with ChangeNotifier {
  List<Monitoria>? monitoria;

  MonitoriaObjects({this.monitoria});

  Future<List<Monitoria>> getMonitoriasbyDate(
      {required DateTime date, required int limit}) async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    monitoria = await MonitoriasService.loadMonitorias(firestore);

    List<Monitoria> monitoriasByDate = (monitoria != [])
        ? monitoria!
            .where((element) =>
                element.date.day == date.day &&
                element.date.month == date.month &&
                element.date.year == date.year)
            .toList()
        : [];

    print("------------------------------------------------------------");
    monitoriasByDate.forEach((element) => print(element.owner.firstName));
    print("------------------------------------------------------------");

    if (monitoriasByDate.length >= limit) {
      throw MonitoriaExceedException(
          "Limite de monitorias por dia excedido. Limite: $limit");
    }
    return monitoriasByDate;
  }

  bool _getMonitoriasbyUser(
      {required List<Monitoria> monitoriaList, required Monitoria mon}) {
    bool monitoriasByDate = monitoriaList
        .where((element) =>
            element.owner.userName == mon.owner.userName &&
            element.date.day == mon.date.day &&
            element.date.month == mon.date.month &&
            element.date.year == mon.date.year)
        .isEmpty;
    print("------------------------------------------------------------");
    print(monitoriasByDate);
    print("------------------------------------------------------------");
    if (monitoriasByDate == false) {
      throw UserAlreadyMarkDateException(
          "${mon.owner.firstName} ja marcou monitoria para esse dia ${mon.date.day}/${mon.date.month}/${mon.date.year}");
    }
    return monitoriasByDate;
  }

  Future<bool> addMonitoria({required Monitoria mon}) async {
    bool mark = false;
    List<Monitoria> mons = await getMonitoriasbyDate(date: mon.date, limit: 10);
    print(mons);

    if (mons == []) {
      mark = true;
    } else {
      mark = _getMonitoriasbyUser(monitoriaList: mons, mon: mon);
    }
    print(mark);
    if (mark) {
      FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
      print(mon.toMap());
      await MonitoriasService.saveMonitoria(
          firestore: firestore, monitoria: mon);

      print("------------------------------------------------------------");
      print(mon.date);
      print(mon.owner.firstName);
      print(mon.status);
      print("------------------------------------------------------------");
      monitoria!.add(mon);
      print("------------------------------------------------------------");
      monitoria!.forEach((element) => print(element.date));
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<List<Monitoria>> getStatusMarcada() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    List<Monitoria> list = await MonitoriasService.loadMonitorias(firestore);
    List<Monitoria> statusMarcada =
        list.where((element) => element.status == "MARCADA").toList();
    return statusMarcada;
  }

  updateStatusMonitoria(
      {required Monitoria mon, required String newStatus}) async {
    List<Monitoria> monitoria =
        await getMonitoriasbyDate(date: mon.date, limit: 10);

    print("------------------------------------------------------------");
    monitoria.forEach((element) => print(element.date));

    for (Monitoria item in monitoria) {
      if (item.id == mon.id) {
        print("${item.toMap()}");
        FirebaseFirestore firestore =
            await FirebaseService.initializeFirebase();
        print("------------------------------------------------------------");
        print("antes: ${item.status}");
        print(item.toMap());
        item.status = newStatus;
        await MonitoriasService.saveMonitoria(
            firestore: firestore, monitoria: item);
        print("depois: ${item.status}");
        print(item.toMap());
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
