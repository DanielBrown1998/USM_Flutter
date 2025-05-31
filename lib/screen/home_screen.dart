import 'package:app/models/objects/user_objects.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app/components/header.dart';
import 'package:app/components/drawer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/components/alert_dialog.dart';
import 'package:app/components/body.dart' as custom_body;
import 'package:provider/provider.dart';

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
            height: 64,
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
      drawer: Consumer<UserObjects>(
          builder: (BuildContext context, value, Widget? child) {
        if (value.user == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListDrawer.list(context,
            user:
                "${value.user!.firstName} ${value.user!.lastName}");
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeUSM.backgroundColor,
        foregroundColor: ThemeUSM.textColor,
        onPressed: () async {
          dynamic value = await alertDialogAddMonitoria(context);
          if (value.runtimeType == List) {
            User user = value[1];
            DateTime date = value[2];
            if (value[0]) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Monitoria marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}"),
                duration: Duration(seconds: 2),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Monitoria NAO marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}"),
                duration: Duration(seconds: 2),
              ));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$value"),
              duration: Duration(seconds: 2),
            ));
          }
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
