import "user.dart";

class Monitoria {
  final User owner;
  final DateTime date;
  final String status;

  Monitoria({required this.owner, required this.date, required this.status});
}
