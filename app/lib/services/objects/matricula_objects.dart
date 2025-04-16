import "package:app/models/matricula.dart";
import "package:flutter/material.dart";

class MatriculaObjects with ChangeNotifier{
  List<Matricula> matriculas;

  MatriculaObjects({required this.matriculas});
}
