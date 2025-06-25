import 'package:app/components/monitoria_card.dart';
import 'package:app/utils/routes/routes.dart';
import 'package:app/utils/theme/theme.dart';

import 'package:provider/provider.dart';
import "package:flutter/material.dart";
import 'package:app/models/settings/monitoria_objects.dart';

class ListBody extends StatefulWidget {
  const ListBody({super.key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttons = {
      "buscar alunos": Routes.searchStudent,
      "matriculas": Routes.matriculas,
      "monitorias": Routes.monitorias,
      "config": Routes.config,
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
            width: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, buttons.values.toList()[i]);
              },
              splashColor: Theme.of(context).primaryColorDark,
              color: ThemeUSM.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                buttons.keys.toList()[i],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
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
            color: ThemeUSM.backgroundColor,
            width: 3,
          ),
        ),
        child: Consumer<MonitoriaObjects>(
          builder:
              (BuildContext context, MonitoriaObjects list, Widget? widget) {
            return FutureBuilder(
              future: list.getStatusMarcada(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (!snapshot.hasData) {
                      return Center(child: Text("Nenhuma monitoria marcada"));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MonitoriaCard(
                          monitoria: snapshot.data![index],
                        );
                      },
                    );
                  case ConnectionState.none:
                    return Center(child: Text("Erro ao carregar dados"));
                  default:
                    return Center(child: Text("Erro desconhecido!"));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
