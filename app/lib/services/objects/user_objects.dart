import "package:app/models/user.dart";
import 'package:flutter/material.dart';

class UserObjects with ChangeNotifier{
  List<User> user;

  UserObjects({required this.user});
}
