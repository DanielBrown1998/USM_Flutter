import "user.dart";

class DataUser {
  final User owner;
  int monitoriasMarcadas;
  int monitoriasPresentes;
  int monitoriasAusentes;
  int monitoriasCanceladas;
  final String phone;

  DataUser(
      {required this.owner,
      this.monitoriasMarcadas = 0,
      this.monitoriasPresentes = 0,
      this.monitoriasCanceladas = 0,
      this.monitoriasAusentes = 0,
      required this.phone});

  DataUser.fromMap(Map<String, dynamic> map)
      : owner = User.fromMap(map["owner"]),
        monitoriasMarcadas = map["monitoriasMarcadas"],
        monitoriasCanceladas = map["monitoriasCanceladas"],
        monitoriasPresentes = map["monitoriasPresentes"],
        monitoriasAusentes = map["monitoriasAusentes"],
        phone = map["phone"];

  Map<String, dynamic> toMap() {
    return {
      "owner": owner.toMap(),
      "monitoriasMarcadas": monitoriasMarcadas,
      "monitoriasAusentes": monitoriasAusentes,
      "monitoriasPresentes": monitoriasPresentes,
      "monitoriasCanceladas": monitoriasCanceladas,
      "phone": phone
    };
  }
}
