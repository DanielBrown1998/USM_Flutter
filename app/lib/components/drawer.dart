import 'package:flutter/material.dart';

class ListDrawer {
  static Widget list(BuildContext context) {
    List<List<Widget>> listWidgets = [
      [
        Text("home",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.home,
          color: Theme.of(context).primaryColor,
        ),
      ],
      [
        Text("dias disponiveis",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.calendar_today,
          color: Theme.of(context).primaryColor,
        ),
      ],
      [
        Text("monitorias hoje",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.today,
          color: Theme.of(context).primaryColor,
        ),
      ],
      [
        Text("config",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.settings,
          color: Theme.of(context).primaryColor,
        ),
      ],
      [
        Text("matriculas",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.vpn_key,
          color: Theme.of(context).primaryColor,
        ),
      ],
      [
        Text("info",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Icon(
          Icons.info,
          color: Theme.of(context).primaryColor,
        ),
      ],
    ];

    return Drawer(
      width: 200,
      backgroundColor: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int i) => Divider(
            color: Theme.of(context).dividerColor,
          ),
          itemCount: listWidgets.length,
          itemBuilder: (BuildContext context, int i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: listWidgets[i],
            );
          },
        ),
      ),
    );
  }
}
