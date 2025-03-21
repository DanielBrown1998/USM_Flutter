import 'package:flutter/material.dart';

class ListDrawer {
  static Drawer list(BuildContext context) {
    List<Widget> listWidgets = [
      DrawerHeader(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage("lib/assets/images/logomarca-uerj.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null,
      ),
      ListTile(
        leading: Icon(Icons.search, color: Theme.of(context).primaryColor),
        title: Text(
          "Alunos",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      ListTile(
        leading: Icon(Icons.assignment_ind_outlined,
            color: Theme.of(context).primaryColor),
        title: Text(
          "Monitoria",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      ListTile(
        leading: Icon(Icons.receipt_long_sharp,
            color: Theme.of(context).primaryColor),
        title: Text(
          "Relatórios",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      ListTile(
        leading: Icon(Icons.settings_applications_outlined,
            color: Theme.of(context).primaryColor),
        title: Text(
          "Configurações",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      ListTile(
        leading: Icon(Icons.volunteer_activism_outlined,
            color: Theme.of(context).primaryColor),
        title: Text(
          "Sobre",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app_outlined,
            color: Theme.of(context).primaryColor),
        title: Text(
          "Sair",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        onTap: () {},
        splashColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
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
            return listWidgets[i];
          },
        ),
      ),
    );
  }
}
