import "package:app/models/days.dart";
import "package:flutter/material.dart";

class DaysObjects with ChangeNotifier{
  List<Days> days;

  DaysObjects({required this.days});
}
