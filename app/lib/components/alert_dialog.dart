import 'package:app/models/disciplinas.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/settings/disciplinas_settings.dart';
import 'package:app/models/user.dart';

import 'package:app/models/settings/monitoria_settings.dart';
import 'package:app/models/settings/user_settings.dart';
import 'package:app/utils/utils_add_monitoria.dart';
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
  required Monitoria monitoriaMarcada,
  required IconData icon,
  required String title,
  required String description,
  required String confirmation,
  required String cancel,
  bool monitoriaOk = true,
}) {
  // DataUserObjects dataUser =
  // Provider.of<DataUserObjects>(context, listen: false);
  MonitoriaSettings monitoria =
      Provider.of<MonitoriaSettings>(context, listen: false);

  AlertDialog alert = AlertDialog(
    icon: Icon(icon),
    elevation: 20,
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
      title,
      style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 20),
    ),
    content: Text(description),
    actions: [
      TextButton(
          onPressed: () async {
            try {
              if (monitoriaOk) {
                await monitoria.updateStatusMonitoria(
                    monitoria: monitoriaMarcada, newStatus: Status.presente);
              } else {
                await monitoria.updateStatusMonitoria(
                    monitoria: monitoriaMarcada, newStatus: Status.ausente);
              }
              if (!context.mounted) return;
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
  //substituindo o usuario autenticado por enquanto!
  UserSettings users = Provider.of<UserSettings>(context, listen: false);
  User? user = users.user;

  final formkey = GlobalKey<FormState>();

  Disciplina? disciplinaByUser;
  DisciplinasSettings allDisciplinas =
      Provider.of<DisciplinasSettings>(context, listen: false);
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
                    initialValue: user!.userName,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Matricula",
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                        helperText: "insira a matricula do aluno"),
                    validator: (value) {
                      return null;
                    },
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
                        if (value != null) disciplinaByUser = value;
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
                    validator: (value) {
                      return null;
                    },
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
            try {
              //TODO refatorar o codigo e por a excessao no modulo

              Map<String, dynamic> isUserValid = isMonitoriaValid(
                  user: user, disciplina: disciplinaByUser, date: date);
              if (!isUserValid["value"]) {
                throw UserisNotAvailableToMonitoriaException(
                    isUserValid['message'].toString());
              }

              Disciplina? disciplinaUpdated = updateDisciplinaData(
                  disciplinaByUser!, allDisciplinas.disciplinas);

              if (disciplinaUpdated == null) {
                //implement removeDisciplinaThisUser
                users.removeDisciplinaThisUser(disciplinaByUser!);
                throw DisciplinaNotFound(message: "disciplina nao encontrada!");
              }
              Monitoria formatedDataToMonitoria =
                  formatAddMonitoria(user, disciplinaByUser!, date);

              MonitoriaSettings monitorias =
                  Provider.of<MonitoriaSettings>(context, listen: false);

              bool isUserAdded = await monitorias.addMonitoria(
                  monitoria: formatedDataToMonitoria);

              List<dynamic> resultAddDataMonitoria = [isUserAdded, user, date];

              if (!context.mounted) return;
              Navigator.pop(context, resultAddDataMonitoria);
            } on MonitoriaExceedException catch (e) {
              Navigator.pop(context, e.message);
            } on UserAlreadyMarkDateException catch (e) {
              Navigator.pop(context, e.message);
            } on UserNotFoundException catch (e) {
              Navigator.pop(context, e.message);
            } on UserisNotAvailableToMonitoriaException catch (e) {
              Navigator.pop(context, e.message);
            } on DisciplinaNotFound catch (e) {
              Navigator.pop(context, e.message);
            } on Exception catch (_) {
              Navigator.pop(context, "Erro desconhecido");
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
          if (!context.mounted) return;
          Navigator.pop(context, true);
        },
        icon: Icon(Icons.add_task),
      ),
      IconButton(
        onPressed: () async {
          if (!context.mounted) return;
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
