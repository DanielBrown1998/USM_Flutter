import "package:app/models/monitoria.dart";
import "package:app/services/firebase_service.dart";
import "package:app/services/monitorias_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:app/utils/constants/constants.dart";

class MonitoriaSettings with ChangeNotifier {
  List<Monitoria> monitoria = [];

  void initializeMonitorias(List<Monitoria> monitoria) {
    this.monitoria = monitoria;
    notifyListeners();
  }

  Future<List<Monitoria>> loadMonitorias() async {
    FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
    return await MonitoriasService.getAllMonitorias(firestore);
  }

  Future<List<Monitoria>> getMonitoriasbyDate(
      {required DateTime date, required int? limit}) async {
    
    monitoria = await loadMonitorias();
    notifyListeners();
    List<Monitoria> monitoriasByDate = (monitoria == [])
        ? monitoria
            .where((element) =>
                element.date.day == date.day &&
                element.date.month == date.month &&
                element.date.year == date.year)
            .toList()
        : [];

    // print("------------------------------------------------------------");
    // for (var element in monitoriasByDate) {
    //   print(element.aluno);
    // }
    // print("------------------------------------------------------------");

    if (limit != null && monitoriasByDate.length >= limit) {
      throw MonitoriaExceedException(
          "Limite de monitorias por dia excedido. Limite: $limit");
    }
    return monitoriasByDate;
  }

  bool _getMonitoriasbyUser(
      {required List<Monitoria> monitorias, required Monitoria monitoria}) {
    bool monitoriasByDate = monitorias
        .where((element) =>
            element.userName == monitoria.userName &&
            element.date.day == monitoria.date.day &&
            element.date.month == monitoria.date.month &&
            element.date.year == monitoria.date.year)
        .isEmpty;
    // print("------------------------------------------------------------");
    // print(monitoriasByDate);
    // print("------------------------------------------------------------");
    if (monitoriasByDate == false) {
      throw UserAlreadyMarkDateException(
          "${monitoria.aluno} ja marcou monitoria para esse dia ${monitoria.date.day}/${monitoria.date.month}/${monitoria.date.year}");
    }
    return monitoriasByDate;
  }

  Future<bool> addMonitoria({required Monitoria monitoria}) async {
    bool isMonitoriaThisDay = false;
    List<Monitoria> monitorias = await getMonitoriasbyDate(
        date: monitoria.date, limit: monitoria.disciplina.limitByDay);
    // print(monitorias);

    if (monitorias == []) {
      isMonitoriaThisDay = true;
    } else {
      isMonitoriaThisDay =
          _getMonitoriasbyUser(monitorias: monitorias, monitoria: monitoria);
    }
    if (isMonitoriaThisDay) {
      FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
      // print(mon.toMap());
      await MonitoriasService.saveMonitoria(
          firestore: firestore, monitoria: monitoria);

      // print("------------------------------------------------------------");
      // print(mon.date);
      // print(mon.aluno);
      // print(mon.status);
      // print("------------------------------------------------------------");
      // monitoria.add(mon);
      // print("------------------------------------------------------------");
      // monitoria.forEach((element) => print(element.date));
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<List<Monitoria>> getStatusMarcada() async {
    List<Monitoria> monitoria = await loadMonitorias();
    List<Monitoria> statusMarcada = monitoria
        .where((element) =>
            element.status.toString().toUpperCase() == Status.marcada)
        .toList();

    return statusMarcada;
  }

  //TODO refactor from for to contains
  updateStatusMonitoria(
      {required Monitoria monitoria, required String newStatus}) async {
    List<Monitoria> monitorias = await getMonitoriasbyDate(
        date: monitoria.date, limit: monitoria.disciplina.limitByDay);

    for (Monitoria item in monitorias) {
      if (item.id == monitoria.id) {
        // print("${item.toMap()}");
        FirebaseFirestore firestore =
            await FirebaseService.initializeFirebase();
        // print("------------------------------------------------------------");
        // print("antes: ${item.status}");
        // print(item.toMap());
        item.status = newStatus;
        await MonitoriasService.saveMonitoria(
            firestore: firestore, monitoria: item);
        // print("depois: ${item.status}");
        // print(item.toMap());
        // print("------------------------------------------------------------");
        notifyListeners();
        return item;
      }
    }
  }
}

class UserisNotAvailableToMonitoriaException implements Exception {
  final String message;
  UserisNotAvailableToMonitoriaException(this.message);
  @override
  String toString() {
    return message;
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
