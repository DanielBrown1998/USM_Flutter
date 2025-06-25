import 'package:app/models/disciplinas.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/user.dart';

import 'package:app/models/settings/days_objects.dart';
import 'package:app/models/settings/monitoria_objects.dart';
import 'package:app/models/settings/user_objects.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:app/utils/constants/constants.dart';

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
                    mon: mon, newStatus: Status.presente);
                // dataUser.updateDataUser(data, "PRESENTE"); //update dataUser
              } else {
                await monitoria.updateStatusMonitoria(
                    mon: mon, newStatus: Status.ausente);
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
  DaysObjects days = Provider.of<DaysObjects>(context, listen: false);
  MonitoriaObjects monitorias =
      Provider.of<MonitoriaObjects>(context, listen: false);
      
  //substituindo o usuario autenticado por enquanto!
  UserObjects users = Provider.of<UserObjects>(context, listen: false);
  User? user = users.user;

  //se user e monitor de uma materia, nao pode pedir monitoria da propria materia que e monitorando
  //superusuario nao pode marcar monitorias

  final formkey = GlobalKey<FormState>();
  final TextEditingController matricula = TextEditingController();
  Disciplinas disciplina = user!.disciplinas[0];
  DateTime date = DateTime.now().add(Duration(days: 1));

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
                      key: Key("add_monitoria_image"),
                      "lib/assets/images/logomarca-uerj.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue: user.userName,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Matricula",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                        helperText: "insira a matricula do aluno"),
                    validator: (value) {},
                    onSaved: (value) {},
                  ),
                  DropdownButtonFormField(
                      items: List.generate(
                          user.disciplinas.length,
                          (index) => DropdownMenuItem(
                                value: user.disciplinas[index],
                                child: Text(user.disciplinas[index].nome),
                              )),
                      decoration: InputDecoration(
                        labelText: "Disciplina",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                      ),
                      onChanged: (value) {
                        if (value != null) disciplina = value;
                      }),
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
            //TODO: check if have available days
            try {
              String id = user.userName +
                  date.day.toString() +
                  date.month.toString() +
                  date.year.toString() +
                  date.hour.toString() +
                  date.minute.toString();
              Monitoria monitoria = Monitoria(
                  id: id,
                  disciplina: disciplina,
                  date: date,
                  aluno: "${user.firstName} ${user.lastName}",
                  userName: user.userName);
              bool mark = await monitorias.addMonitoria(mon: monitoria);
              List<dynamic> result = [mark, user, date];
              Navigator.pop(context, result);
            } on MonitoriaExceedException catch (e) {
              Navigator.pop(context, e.message);
            } on UserAlreadyMarkDateException catch (e) {
              Navigator.pop(context, e.message);
            } on UserNotFoundException catch (e) {
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

Future<dynamic> alertDialogAddMatricula(BuildContext context) {
  TextEditingController matricula = TextEditingController();

  AlertDialog alert = AlertDialog(
    content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: matricula,
              decoration: InputDecoration(
                labelText: "Matricula",
                icon: Icon(Icons.person),
              ),
            ),
          ],
        )),
    actions: [
      IconButton(
        onPressed: () async {
          print(matricula.text);
          Navigator.pop(context, true);
        },
        icon: Icon(Icons.add_task),
      ),
      IconButton(
        onPressed: () async {
          Navigator.pop(context, false);
        },
        icon: Icon(Icons.highlight_remove_sharp),
      )
    ],
    alignment: Alignment.center,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text("Add Matricula"),
    titleTextStyle: TextStyle(
      color: ThemeUSM.textColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    elevation: 10,
    icon: Icon(Icons.add),
    iconColor: ThemeUSM.textColor,
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
