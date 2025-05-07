import "package:app/models/data_user.dart";
import "package:app/models/user.dart";
import "package:flutter_test/flutter_test.dart";
import "package:app/models/monitoria.dart";
import "package:app/models/objects/monitoria_objects.dart";

void main() {
  User userRoot = User(
      email: "daniel@xpto.com",
      firstName: "Daniel",
      lastName: "Passos",
      userName: "202213313611",
      password: "hash123",
      isStaff: true,
      isSuperUser: true,
      isActive: true,
      dateJoined: DateTime.now(),
      lastLogin: DateTime.now());

  DataUser dataUser = DataUser(owner: userRoot, phone: "21999998888");

  Monitoria mon = Monitoria(owner: userRoot, date: DateTime.now());

  List<Monitoria> mons = [];
  MonitoriaObjects monitorias = MonitoriaObjects(monitoria: mons);

  monitorias.addMonitoria(dataUser: dataUser, mon: mon);

  test("Buscando monitorias de hoje!", () {
    List<Monitoria> monitoriasToday =
        monitorias.getMonitoriasbyDate(date: DateTime.now(), limit: 10);
    expect(monitoriasToday.length, 1);
  });

  test("Buscando monitoria por Usuario e Data", () {
    DateTime date = DateTime.now().add(const Duration(days: 1));
    bool monitoriasUser = monitorias.getMonitoriasbyUser(
        monitoriaList: mons, date: date, dataUser: dataUser);
    expect(monitoriasUser, true);
  });
}
