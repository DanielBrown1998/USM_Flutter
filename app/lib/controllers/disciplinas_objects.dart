import 'package:flutter/material.dart';
import 'package:app/models/disciplinas.dart';

class DisciplinasObjects with ChangeNotifier {
  List<Disciplinas> disciplinas;

  DisciplinasObjects({required this.disciplinas});
}
