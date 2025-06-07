import "user.dart";

class Monitoria {
  final String id;
  final User owner;
  final DateTime date;
  String status;

  Monitoria(
      {required this.id,
      required this.owner,
      required this.date,
      this.status = "MARCADA"});

  Monitoria.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        owner = User.fromMap(map["owner"]),
        date = map["date"].toDate(),
        status = map["status"];

  Map<String, dynamic> toMap() {
    return {"id": id, "owner": owner.toMap(), "date": date, "status": status};
  }
}
