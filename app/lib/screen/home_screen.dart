import 'package:app/components/appbar.dart';
import 'package:app/models/settings/user_settings.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:app/components/header.dart';
import 'package:app/components/drawer.dart';
import 'package:app/utils/theme/theme.dart';
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
      appBar: USMAppBar.appBar(context, widget.title, hasDrawer: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Header(
              key: Key("home_screen_header"),
            ),
          ),
          SizedBox(
            height: 64,
            child: custom_body.ListBody(
              key: Key("home_screen_list"),
            ),
          ),
          Expanded(
            child: custom_body.MonitoriaView(
              key: Key("home_screen_monitoria"),
            ),
          ),
        ],
      ),
      drawer: Consumer<UserSettings>(
          builder: (BuildContext context, value, Widget? child) {
        if (value.user == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListDrawer.list(context,
            user: "${value.user!.firstName} ${value.user!.lastName}");
      }),
      floatingActionButton: FloatingActionButton(
        key: Key("add_monitoria"),
        backgroundColor: ThemeUSM.backgroundColor,
        foregroundColor: ThemeUSM.textColor,
        onPressed: () async {
          dynamic value = await alertDialogAddMonitoria(context);
          if (value.runtimeType == List) {
            User user = value[1];
            DateTime date = value[2];
            if (value[0]) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Monitoria marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}"),
                duration: Duration(seconds: 2),
              ));
            } else {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Monitoria NAO marcada: ${date.day}-${date.month}-${date.year}, ${user.firstName}"),
                duration: Duration(seconds: 2),
              ));
            }
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
