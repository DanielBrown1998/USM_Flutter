import 'package:app/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class USMAppBar {
  static AppBar appBar(BuildContext context, String title,
      {bool hasDrawer = false}) {
    return AppBar(
      leading: Builder(builder: (context) {
        return hasDrawer
            ? IconButton(
                icon: const Icon(Icons.menu),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : IconButton(
                key: Key("back_button_appbar"),
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
      }),
      actions: [
        Hero(
          tag: "account",
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.userScreen);
              },
              icon: Icon(Icons.account_box_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.update),
          ),
        ),
      ],
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
