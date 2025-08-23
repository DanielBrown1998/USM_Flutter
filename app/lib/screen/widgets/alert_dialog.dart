import 'package:app/domain/models/disciplinas.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/controllers/disciplinas_controllers.dart';
import 'package:app/domain/models/user.dart';

import 'package:app/controllers/monitoria_controllers.dart';
import 'package:app/controllers/user_controllers.dart';
import 'package:app/core/utils/utils_add_monitoria.dart';
import 'package:app/core/constants/constants.dart';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';

Future<dynamic> alertDialogStudent(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String msg,
  required String confirmation,
}) {
  final theme = Theme.of(context);
  AlertDialog alert = AlertDialog(
    icon: Icon(icon),
    elevation: 20,
    backgroundColor: theme.primaryColor,
    title: Text(
      title,
      style: TextStyle(color: theme.dividerColor, fontSize: 20),
    ),
    content: Text(msg),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(
            confirmation,
            style: TextStyle(color: theme.cardColor, fontSize: 15),
          )),
      // TextButton(
      //     onPressed: () {
      //       Navigator.pop(context, false);
      //     },
      //     child: Text(
      //       cancel,
      //       style: TextStyle(color: theme.cardColor, fontSize: 15),
      //     )),
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
  MonitoriaController monitoria =
      Provider.of<MonitoriaController>(context, listen: false);
  final theme = Theme.of(context);

  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        icon: Icon(icon),
        elevation: 20,
        backgroundColor: theme.primaryColor,
        title: Text(
          title,
          style: theme.textTheme.bodyLarge,
        ),
        content: Text(
          description,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  Monitoria? monitoriaUpdated =
                      await monitoria.updateStatusMonitoria(
                          monitoria: monitoriaMarcada,
                          newStatus:
                              (monitoriaOk) ? Status.presente : Status.ausente);
                  if (!dialogContext.mounted) return;
                  Navigator.pop(dialogContext, monitoriaUpdated);
                } on StatusMOnitoriaException catch (e) {
                  Navigator.pop(dialogContext, e.message);
                } catch (e) {
                  Navigator.pop(dialogContext, e.toString());
                }
              },
              child: Text(
                confirmation,
                style: TextStyle(color: theme.cardColor, fontSize: 15),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                cancel,
                style: TextStyle(color: theme.cardColor, fontSize: 15),
              )),
        ],
      );
    },
  );
}

Future<dynamic> alertDialogAddMonitoria(BuildContext context) {
  //substituindo o usuario autenticado por enquanto!
  UserController users = Provider.of<UserController>(context, listen: false);
  User? user = users.user;

  final formkey = GlobalKey<FormState>();

  Disciplina? disciplinaByUser;
  DisciplinasController allDisciplinas =
      Provider.of<DisciplinasController>(context, listen: false);
  DateTime date = DateTime.now().add(Duration(days: 1));
  final media = MediaQuery.of(context);
  final theme = Theme.of(context);
  AlertDialog alert = AlertDialog(
    backgroundColor: theme.primaryColor,
    elevation: 20,
    shadowColor: theme.colorScheme.onPrimaryFixed,
    insetPadding: EdgeInsets.zero,
    title: Text(
      "Add Monitoria",
    ),
    titleTextStyle: theme.textTheme.bodyLarge,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: theme.colorScheme.onPrimaryFixed,
        width: 4,
      ),
    ),
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(
          maxHeight: 500,
          minHeight: 350,
          maxWidth: double.maxFinite,
          minWidth: 200),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 20,
          children: [
            SizedBox(
              width: media.size.width * 0.3,
              height: media.size.width * 0.3,
              child: Image.asset(
                key: Key("add_monitoria_image"),
                "assets/images/logomarca-uerj.png",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Form(
                key: formkey,
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
                      enabled: false,
                      initialValue: user!.userName,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Matricula",
                          labelStyle: theme.textTheme.bodyMedium,
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
                          labelStyle: theme.textTheme.bodyMedium,
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
                          labelStyle: theme.textTheme.bodyMedium,
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
    ),
    actions: [
      IconButton(
          onPressed: () async {
            try {
              //TODO refatorar o codigo e por a excessao no modulo
              //usuario esta apto a pedir essa monnitoria?
              Map<String, dynamic> isUserValid = isMonitoriaValid(
                  user: user, disciplina: disciplinaByUser, date: date);
              if (!isUserValid["value"]) {
                throw UserisNotAvailableToMonitoriaException(
                    isUserValid['message'].toString());
              }
              //atualizando a disciplina contida no usuario
              Disciplina? disciplinaUpdated = updateDisciplinaData(
                  disciplinaByUser!, allDisciplinas.disciplinas);

              if (disciplinaUpdated != null) {
                disciplinaByUser = disciplinaUpdated;
              }
              //formatando a monitoria
              Monitoria formatedDataToMonitoria =
                  formatAddMonitoria(user, disciplinaByUser!, date);

              //carregando as monitorias
              MonitoriaController monitorias =
                  Provider.of<MonitoriaController>(context, listen: false);

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
            } on DisciplinaNotFoundException catch (e) {
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
