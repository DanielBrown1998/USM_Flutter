import 'package:flutter/material.dart';
import 'package:app/components/header.dart';
import 'package:app/components/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  List<String> nameButtons = <String>[
    "buscar aluno",
    "atualizar monitoria",
    "add monitoria",
    "cancelar monitoria",
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.update)),
          ),
        ],
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              borderOnForeground: true,
              elevation: 10,
              shadowColor: ThemeData().cardColor,
              child: Header(
                key: Key("home_screen"),
              ),
            ),
          ),
          Container(
            height: 500,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: nameButtons.length,
              itemBuilder: (context, int i) {
                return Card(
                    borderOnForeground: true,
                    elevation: 10,
                    shadowColor: ThemeData().cardColor,
                    child: Container(
                      height: 75,
                      child: TextButton(
                          onPressed: () {}, child: Text(nameButtons[i])),
                    ));
              },
            ),
          ),
        ],
      ),
      drawer: ListDrawer.list(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
