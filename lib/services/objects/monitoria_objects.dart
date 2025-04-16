import "package:app/models/monitoria.dart";
import "package:flutter/material.dart";

class MonitoriaObjects with ChangeNotifier{
  List<Monitoria> monitoria;

  MonitoriaObjects({required this.monitoria});
}
