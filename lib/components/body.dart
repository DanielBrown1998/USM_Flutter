import "dart:async";

import "package:flutter/material.dart";
import "package:app/components/alert_dialog.dart";

class ListBody extends StatefulWidget {
  const ListBody({super.key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttons = {
      "buscar alunos": "/search_student",
      "inserir matriculas": null,
      "resetar senha": null,
      "alterar dia da monitoria": null,
    };
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: buttons.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int i) {
        return Card(
          borderOnForeground: true,
          elevation: 10,
          child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, buttons.values.toList()[i]);
              },
              splashColor: Theme.of(context).primaryColorDark,
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                buttons.keys.toList()[i],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MonitoriaView extends StatefulWidget {
  const MonitoriaView({super.key});

  @override
  State<MonitoriaView> createState() => _MonitoriaViewState();
}

class _MonitoriaViewState extends State<MonitoriaView> {
  final List<dynamic> listMonitorias = <dynamic>[
    "monitoria 1",
    "monitoria 2",
    "monitoria 3",
    "monitoria 4",
    "monitoria 5",
    "monitoria 6",
    "monitoria 7",
    "monitoria 8",
    "monitoria 9",
    "monitoria 10",
  ];

  final List<dynamic> historyMonitorias = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: listMonitorias.length,
          itemBuilder: (context, int i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${listMonitorias[i]}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //confirmation button
                  IconButton(
                    onPressed: () {
                      alertDialogStudent(context,
                              icon: Icons.dangerous_outlined,
                              title: "Atencao",
                              confirmation: "sim",
                              cancel: "nao",
                              msg:
                                  "deseja alterar o status da msg para concluido")
                          .then((value) {
                        print(value);
                        if (value == true) {
                          setState(() {
                            dynamic item = listMonitorias.removeAt(i);
                            historyMonitorias.add(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("$item concluida")));
                          });
                        }
                      } as FutureOr Function(void value));
                    },
                    icon: Icon(Icons.check,
                        color: Theme.of(context).primaryColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  //no confirmation button
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).dividerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Icon(Icons.delete,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {
                      alertDialogStudent(context,
                              icon: Icons.dangerous_outlined,
                              title: "Atencao",
                              confirmation: "sim",
                              cancel: "nao",
                              msg:
                                  "deseja alterar o status da msg para nao concluido")
                          .then((value) {
                        print(value);
                        if (value == true) {
                          setState(() {
                            dynamic item = listMonitorias.removeAt(i);
                            historyMonitorias.add(item);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(" $item nao concluida")));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("cancelada")));
                        }
                      } as FutureOr Function(void value));
                      ;
                    },
                  ),
                ])
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Theme.of(context).dividerColor,
              height: 2,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            );
          },
        ),
      ),
    );
  }
}
