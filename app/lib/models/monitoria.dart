import "user.dart";

class Monitoria {
  final User owner;
  final DateTime date;
  String status;

  Monitoria({required this.owner, required this.date, this.status = "MARCADA"});
}
