import 'package:flutter/material.dart';
import 'package:app/theme/theme.dart';

class ListTileWidget extends StatelessWidget {
  final IconData iconName;
  final Color iconColor;
  final String text;
  final Color colorText;
  final double fontSizetext;
  final Color splashColor;

  const ListTileWidget(
      {super.key,
      required this.iconName,
      required this.iconColor,
      required this.text,
      required this.colorText,
      required this.fontSizetext,
      required this.splashColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconName, color: iconColor),
      title: Text(
        text,
        style: TextStyle(
          color: colorText,
          fontSize: fontSizetext,
        ),
      ),
      onTap: () {},
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

class ListDrawer {
  static Drawer list(BuildContext context) {
    List<Widget> listWidgets = [
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/images/back-720.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assets/images/logomarca-uerj.png",
                    height: 50,
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "MONITORIA",
                      style: TextStyle(
                        color: ThemeUSM.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                    color: ThemeUSM.textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Daniel Brown",
                    style: TextStyle(
                      color: ThemeUSM.textColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ListTileWidget(
        iconName: Icons.search,
        iconColor: ThemeUSM.textColor,
        text: "Alunos",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.assignment_ind_outlined,
        iconColor: ThemeUSM.textColor,
        text: "Monitoria",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.receipt_long_sharp,
        iconColor: ThemeUSM.textColor,
        text: "Relatorios",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.settings_applications_outlined,
        iconColor: ThemeUSM.textColor,
        text: "Configuracoes",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.volunteer_activism_outlined,
        iconColor: ThemeUSM.textColor,
        text: "Sobre",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.exit_to_app_outlined,
        iconColor: ThemeUSM.textColor,
        text: "Sair",
        colorText: ThemeUSM.textColor,
        fontSizetext: 14,
        splashColor: ThemeUSM.dividerDrawerColor,
      ),
    ];

    return Drawer(
      width: 200,
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
