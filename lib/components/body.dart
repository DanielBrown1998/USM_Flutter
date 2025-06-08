import 'package:app/components/monitoria_card.dart';
import 'package:app/theme/theme.dart';

import 'package:provider/provider.dart';
import "package:flutter/material.dart";
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
      "matriculas": null,
      "monitorias": "/monitorias",
      "config.": null,
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
        child: Consumer<MonitoriaObjects>(builder:
            (BuildContext context, MonitoriaObjects list, Widget? widget) {
          return FutureBuilder(
              future: list.getStatusMarcada(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, int i) {
                      return MonitoriaCard(monitoria: snapshot.data![i]);
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
                return Container(); // Return an empty container or another widget if connectionState is not done
              });
        }),
      ),
    );
  }
}
