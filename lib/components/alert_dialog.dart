//TODO passar todo o codigo comentado para o body com o .then()


// import 'package:app/models/matricula.dart';
// import 'package:app/models/data_user.dart';
// import 'package:app/models/days.dart';
// import 'package:app/models/user.dart';

// import 'package:app/services/objects/data_user_objects.dart';
// import 'package:app/services/objects/days_objects.dart';
// import 'package:app/services/objects/matricula_objects.dart';
// import 'package:app/services/objects/user_objects.dart';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
// import 'package:provider/provider.dart';

Future<dynamic> alertDialogStudent(BuildContext context,
    {required IconData icon,
    required String title,
    required String msg,
    required String confirmation,
    required String cancel}) {
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
            print("sim");
            Navigator.pop(context, true);
          },
          child: Text(
            confirmation,
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          )),
      TextButton(
          onPressed: () {
            print("nao");
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
  // User? user;

  // MatriculaObjects matriculas =
  //     Provider.of<MatriculaObjects>(context, listen: false);
  // DataUserObjects dataUser =
  //     Provider.of<DataUserObjects>(context, listen: false);
  // UserObjects users = Provider.of<UserObjects>(context, listen: false);

  // DaysObjects days = Provider.of<DaysObjects>(context, listen: false);

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
                    validator: (value) {

                      // bool varControl = false;
                      // if (matricula.text.length != 12) {
                      //   return "Matricula errada!";
                      // }
                      // for (Matricula item in matriculas.matriculas) {
                      //   if (item.matricula == value) {
                      //     //verificar se possui usuario com essa matricula
                      //     for (User item in users.user) {
                      //       if (item.userName == value) {
                      //         varControl == true;
                      //         user = item;
                      //         break;
                      //       }
                      //     }
                      //   }
                      // }

                      // if (varControl == true) {
                      //   return null;
                      // } else {
                      //   return "MAtricula nao encontrada!";
                      // }
                    },
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
                    validator: (value) {
                      // if (value == null) {
                      //   return "insira uma data valida para monitoria";
                      // }

                      // List<String> daysWeek = [
                      //   'domingo',
                      //   'segunda-feira',
                      //   'terca-feira',
                      //   'quarta=feira',
                      //   'quinta-feira',
                      //   'sexta-feira',
                      //   'sabado'
                      // ];

                      // String dayWeek = daysWeek[value.weekday];
                      // if (!days.days.contains(Days(days: dayWeek))) {
                      //   return "$dayWeek nao e dia de monitoria";
                      // }
                      // return null;
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
          onPressed: () {
            Navigator.pop(context, <dynamic>[date, matricula.text]);
          },
          icon: Icon(Icons.add_task)),
      IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(Icons.cancel))
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
