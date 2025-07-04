import 'package:app/models/disciplinas.dart';

class User {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String? password;
  final bool isStaff;
  final bool isActive;
  final bool isSuperUser;
  final DateTime lastLogin;
  final DateTime dateJoined;
  final List<Disciplina> disciplinas;
  final String campus;

  User(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.password,
      required this.isStaff,
      required this.isActive,
      required this.isSuperUser,
      required this.lastLogin,
      required this.dateJoined,
      required this.disciplinas,
      required this.campus});

  User.fromMap(Map<String, dynamic> map)
      : firstName = map["firstName"],
        lastName = map["lastName"],
        userName = map["userName"],
        email = map["email"],
        password = map["password"],
        isStaff = map["isStaff"],
        isActive = map["isActive"],
        isSuperUser = map["isSuperUser"],
        lastLogin = map["lastLogin"].toDate(),
        dateJoined = map["dateJoined"].toDate(),
        disciplinas = List.generate(map["disciplinas"].length,
            (index) => Disciplina.fromMap(map["disciplinas"][index])),
        campus = map["campus"];

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "email": email,
      "password": password,
      "isStaff": isStaff,
      "isActive": isActive,
      "isSuperUser": isSuperUser,
      "lastLogin": lastLogin,
      "dateJoined": dateJoined,
      "disciplinas": disciplinas.map(
        (Disciplina value) => value.toMap(),
      ),
      "campus": campus,
    };
  }
}
