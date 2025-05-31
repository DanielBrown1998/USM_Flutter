import "user.dart";

class Monitoria {
  final User owner;
  final DateTime date;
  String status;

  Monitoria({required this.owner, required this.date, this.status = "MARCADA"});

  Monitoria.fromMap(Map<String, dynamic> map)
      : owner = User.fromMap(map["owner"]),
        date = map["date"].toDate(),
        status = map["status"];

  Map<String, dynamic> toMap() {
    return {"owner": owner.toMap(), "date": date, "status": status};
  }
}
