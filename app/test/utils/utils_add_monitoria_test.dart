import 'package:app/models/disciplinas.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/utils_add_monitoria.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //TODO refatorar testes para usar o mockito e testar as excecoes

  test('verificando se uma monitoria pode ser marcada por um usuario comum',
      () {
    Disciplina disciplina = Disciplina(
      id: "FCEE01-14755",
      limitByDay: null,
      nome: "Programacao",
      monitor: "202213313611",
      campus: "Zona Oeste",
    );

    DateTime date = DateTime(2026, 10, 1, 10, 0);

    User user = User(
        userName: "202213313611",
        campus: "Zona Oeste",
        email: "daniel_mingozzi@hotmail.com",
        disciplinas: [disciplina],
        firstName: "Daniel",
        lastName: "Mingozzi",
        dateJoined: DateTime(2023, 1, 1),
        isSuperUser: false,
        isStaff: false,
        isActive: true,
        lastLogin: DateTime(2023, 1, 1),
        uid: "");

    Map<String, dynamic> result =
        isMonitoriaValid(user: user, disciplina: disciplina, date: date);

    expect(result["value"], true);
    expect(result["message"],
        "Usuario pode marcar monitoria para essa disciplina e data");

    Monitoria monitoria = formatAddMonitoria(user, disciplina, date);
    expect(monitoria, isA<Monitoria>());
  });
}
