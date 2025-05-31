import 'package:app/models/data_user.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/user.dart';

import 'package:app/models/objects/data_user_objects.dart';
import 'package:app/models/objects/days_objects.dart';
import 'package:app/models/objects/matricula_objects.dart';
import 'package:app/models/objects/monitoria_objects.dart';
import 'package:app/models/objects/user_objects.dart';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';

Future<dynamic> alertDialogStudent(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String msg,
  required String confirmation,
  required String cancel,
}) {
  AlertDialog alert = AlertDialog(
    icon: Icon(icon),
    elevation: 20,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 20),
    ),
    content: Text(msg),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            confirmation,
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          )),
      TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(
            cancel,
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          )),
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<dynamic> alertDialogStatusMonitoria(
  BuildContext context, {
  required User user,
  required IconData icon,
  required String title,
  required String msg,
  required String confirmation,
  required String cancel,
  required DateTime date,
  bool monitoriaOk = true,
}) {
  DataUserObjects dataUser =
      Provider.of<DataUserObjects>(context, listen: false);
  MonitoriaObjects monitoria =
      Provider.of<MonitoriaObjects>(context, listen: false);

  AlertDialog alert = AlertDialog(
    icon: Icon(icon),
    elevation: 20,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 20),
    ),
    content: Text(msg),
    actions: [
      TextButton(
          onPressed: () {
            DataUser data = dataUser.dataUser!;
            try {
              if (monitoriaOk) {
                monitoria.updateStatusMonitoria(
                    user: data, date: date, status: "PRESENTE");
                dataUser.updateDataUser(data, "PRESENTE"); //update dataUser
              } else {
                monitoria.updateStatusMonitoria(
                    user: data, date: date, status: "AUSENTE");
                dataUser.updateDataUser(data, "AUSENTE"); //update dataUser
              }
              Navigator.pop(context, true);
            } on StatusMOnitoriaException catch (e) {
              Navigator.pop(context, e.message);
            } catch (e) {
              Navigator.pop(context, e.toString());
            }
          },
          child: Text(
            confirmation,
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          )),
      TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(
            cancel,
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          )),
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<dynamic> alertDialogAddMonitoria(BuildContext context) {
  final formkey = GlobalKey<FormState>();
  final TextEditingController matricula = TextEditingController();
  DateTime date = DateTime.now().add(Duration(days: 1));

  UserObjects users = Provider.of<UserObjects>(context, listen: false);
  DataUserObjects dataUser =
      Provider.of<DataUserObjects>(context, listen: false);
  //substituindo o usuario autenticado por enquanto!
  User? user = users.user;

  MatriculaObjects matriculas =
      Provider.of<MatriculaObjects>(context, listen: false);
  DaysObjects days = Provider.of<DaysObjects>(context, listen: false);
  
  MonitoriaObjects monitorias =
      Provider.of<MonitoriaObjects>(context, listen: false);

  AlertDialog alert = AlertDialog(
    content: SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    "Add Monitoria",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  TextFormField(
                    controller: matricula,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Matricula",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                        helperText: "insira a matricula do aluno"),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  DateTimeFormField(
                    onChanged: (newValue) {
                      if (newValue != null) {
                        date = newValue;
                      }
                    },
                    firstDate: DateTime.now().add(Duration(days: 1)),
                    lastDate: DateTime.now().add(Duration(days: 8)),
                    decoration: InputDecoration(
                        labelText: "Insira o Dia",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                        helperText: "insira um dia da semana disponivel"),
                    validator: (value) {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            //TODO: check if user is staff
            //TODO: check if matricula is in data
            //TODO: check if have available days
            try {
              //substituindo o usuario autenticado
              // User userMon = users.getUserByMatricula(matricula.text);
              // DataUser data = dataUser.dataUser;
              Monitoria monitoria = Monitoria(owner: user!, date: date);
              //TODO set on firestore
              bool mark = monitorias.addMonitoria(mon: monitoria);
              dataUser.addMonitoria();
              List<dynamic> result = [mark, user, date];
              Navigator.pop(context, result);
            } on MonitoriaExceedException catch (e) {
              Navigator.pop(context, e.message);
            } on UserAlreadyMarkDateException catch (e) {
              Navigator.pop(context, e.message);
            } on UserNotFoundException catch (e) {
              Navigator.pop(context, e.message);
            } on DataUserNotFoundException catch (e) {
              Navigator.pop(context, e.message);
            }
          },
          icon: Icon(Icons.add_task)),
      IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.highlight_remove_sharp))
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
