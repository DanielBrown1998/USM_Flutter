import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

Future<void> alertDialogStudent(BuildContext context,
    {required IconData icon, required String title, required String msg}) {
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
            Navigator.of(context).pop();
          },
          child: Text(
            "voltar",
            style: TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
          ))
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



Future<void> alertDialogAddMonitoria(BuildContext context) {

  final formkey = GlobalKey<FormState>();
  final TextEditingController matricula = TextEditingController();
  late TextEditingController day = TextEditingController();
  late String weekday;
  late String month;

    
  AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text("Add Monitoria", style: Theme.of(context).textTheme.displayLarge,),
                    TextFormField(
                      controller: matricula,
                      decoration: InputDecoration(
                          labelText: "Matricula",
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                          helperText: "insira a matricula do aluno"),
                      validator: (value) {
                        if (matricula.text.length != 12) {
                          return "Matricula errada!";
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    DateTimeFormField(
                      decoration: InputDecoration(
                          labelText: "Insira o Dia",
                          labelStyle: Theme.of(context).textTheme.displayMedium,
                          helperText: "insira um dia da semana disponivel"),
                      validator: (value) {
                        if (day.text.isEmpty) {
                          return "insira uma data disponivel para monitoria";
                        }
                        return null;
                      },
                      onChanged: (DateTime? value) {
                        if (value != null) {
                          day = value.day as TextEditingController;
                          weekday = value.weekday as String;
                          month = value.month as String;
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



