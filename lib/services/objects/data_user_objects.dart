import 'package:app/models/data_user.dart';
import 'package:flutter/material.dart';

class DataUserObjects with ChangeNotifier {
  List<DataUser> dataUser;

  DataUserObjects({required this.dataUser});

  addMonitoria(DataUser user) {
    dataUser.forEach((DataUser value) {
      if (value == user) {
        user.monitoriasMarcadas++;
      }
    });
  }

  

}
