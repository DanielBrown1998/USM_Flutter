import 'package:flutter/material.dart';
import 'package:app/components/header.dart';
import 'package:app/components/drawer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/components/alert_dialog.dart';
import 'package:app/components/body.dart' as custom_body;

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUSM.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_box_outlined),
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
          widget.title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Header(
              key: Key("home_screen"),
            ),
          ),
          SizedBox(
            height: 100,
            child: custom_body.ListBody(
              key: Key("home_screen"),
            ),
          ),
          Expanded(
            child: custom_body.MonitoriaView(
              key: Key("home_screen"),
            ),
          ),
        ],
      ),
      drawer: ListDrawer.list(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeUSM.buttonColor,
        foregroundColor: ThemeUSM.textColor,
        onPressed: () async {
          await alertDialogAddMonitoria(context);
        },
        tooltip: 'Increment',
        elevation: 10,
        heroTag: "add_monitoria",
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
