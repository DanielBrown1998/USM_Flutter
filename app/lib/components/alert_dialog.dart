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
  required Monitoria mon,
  required IconData icon,
  required String title,
  required String msg,
  required String confirmation,
  required String cancel,
  bool monitoriaOk = true,
}) {
  // DataUserObjects dataUser =
  // Provider.of<DataUserObjects>(context, listen: false);
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
          onPressed: () async {
            // DataUser data = dataUser.dataUser!;
            print(mon.toMap());
            try {
              if (monitoriaOk) {
                await monitoria.updateStatusMonitoria(
                    mon: mon, newStatus: "PRESENTE");
                // dataUser.updateDataUser(data, "PRESENTE"); //update dataUser
              } else {
                await monitoria.updateStatusMonitoria(
                    mon: mon, newStatus: "AUSENTE");
                // dataUser.updateDataUser(data, "AUSENTE"); //update dataUser
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
  // DataUserObjects dataUser =
  //     Provider.of<DataUserObjects>(context, listen: false);
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(
                      "lib/assets/images/logomarca-uerj.png",
                      fit: BoxFit.contain,
                    ),
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
          onPressed: () async {
            //TODO: check if user is staff
            //TODO: check if matricula is in data
            //TODO: check if have available days
            try {
              //substituindo o usuario autenticado
              // User userMon = users.getUserByMatricula(matricula.text);
              // DataUser data = dataUser.dataUser;
              String id = user!.userName +
                  date.day.toString() +
                  date.month.toString() +
                  date.year.toString() +
                  date.hour.toString() +
                  date.minute.toString();
              Monitoria monitoria = Monitoria(id: id, owner: user, date: date);
              bool mark = await monitorias.addMonitoria(mon: monitoria);
              // dataUser.addMonitoria();
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
