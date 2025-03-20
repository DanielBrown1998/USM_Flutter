import 'package:flutter/material.dart';
import 'package:app/components/header.dart';
import 'package:app/components/drawer.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.logout),
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.update),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
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
        onPressed: () {},
        tooltip: 'Increment',
        elevation: 10,
        heroTag: "add_monitoria",
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    
    );
  }
}
