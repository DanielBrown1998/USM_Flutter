import 'package:app/models/monitoria.dart';
import 'package:provider/provider.dart';
import "package:flutter/material.dart";
import "package:app/components/alert_dialog.dart";
import 'package:app/models/objects/monitoria_objects.dart';

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
        child: Consumer<MonitoriaObjects>(builder: (BuildContext context,
            MonitoriaObjects listMonitorias, Widget? widget) {
          List<Monitoria>? list = listMonitorias.getStatusMarcada();
          if (list == null || list.isEmpty) {
            return const Center(
              child: Text(
                "Nenhuma monitoria marcada",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: listMonitorias.getStatusMarcada()!.length,
              itemBuilder: (context, int i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          list[i].owner.userName,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Theme.of(context).cardColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                          ),
                        ),
                        Text(
                          "${list[i].date.day}-${list[i].date.month}-${list[i].date.year}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Theme.of(context).cardColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Roboto",
                          ),
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      //confirmation button
                      IconButton(
                        onPressed: () async {
                          bool value = await alertDialogStatusMonitoria(context,
                              icon: Icons.dangerous_outlined,
                              title: "Alterar Status Monitoria",
                              confirmation: "sim",
                              cancel: "nao",
                              msg:
                                  "deseja alterar o status da msg para concluido",
                              user: list[i].owner,
                              date: list[i].date);
                          if (value == true) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${listMonitorias.monitoria[i].owner.userName} realizou a monitoria!")));
                          } else if (value == false) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    " status nao alterado para ${listMonitorias.monitoria[i].owner.userName}")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Erro: ${value.toString()}")));
                          }
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
                        onPressed: () async {
                          bool value = await alertDialogStatusMonitoria(context,
                              icon: Icons.dangerous_outlined,
                              title: "Alterar Status Monitoria",
                              confirmation: "sim",
                              cancel: "nao",
                              msg:
                                  "deseja alterar o status da msg para nao concluido",
                              user: list[i].owner,
                              date: list[i].date,
                              monitoriaOk: false);
                          if (value == true) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    " ${listMonitorias.monitoria[i].owner.userName} nao realizou a monitoria")));
                          } else if (value == false) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    " status nao alterado para ${listMonitorias.monitoria[i].owner.userName}")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Erro: ${value.toString()}")));
                          }
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
            );
          }
        }),
      ),
    );
  }
}
