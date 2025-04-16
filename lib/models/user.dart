class User {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final bool isStaff;
  final bool isActive;
  final bool isSuperUser;
  final DateTime lastLogin;
  final DateTime dateJoined;

  User({
    required this.firstName,
    required this.lastName, 
    required this.userName,
    required this.email,
    required this.password,
    required this.isStaff,
    required this.isActive,
    required this.isSuperUser,
    required this.lastLogin,
    required this.dateJoined
  });
}
