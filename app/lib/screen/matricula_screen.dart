import 'package:app/components/alert_dialog.dart';
import 'package:app/components/appbar.dart';
import 'package:app/components/header.dart';
import 'package:app/models/settings/matricula_settings.dart';
import 'package:app/models/matricula.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatriculaScreen extends StatefulWidget {
  const MatriculaScreen({super.key});
  @override
  State<MatriculaScreen> createState() => _MatriculaScreenState();
}

class _MatriculaScreenState extends State<MatriculaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: USMAppBar.appBar(context, "Matriculas"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Header(
              key: Key("matricula_screen_header"),
            ),
          ),
          Expanded(
            child: Consumer<MatriculaSettings>(
              builder: (context, value, child) {
                return FutureBuilder(
                  future: value.getAllMatriculas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Matricula data = snapshot.data![index];
                          return Dismissible(
                            key: Key(data.matricula),
                            child: ListTile(
                              tileColor: Theme.of(context).primaryColor,
                              onTap: () {},
                              title: Text(data.matricula),
                              subtitle: Text(
                                  "numero de disciplinas: ${data.disciplina.length.toString()}"),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Center(child: Text("Erro ao carregar dados"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      return Center(child: Text("Erro desconhecido!"));
                    } else {
                      return Center(child: Text("Erro desconhecido!"));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: Key("add_matricula"),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          if (context.mounted) {
            // dynamic value = 
            await alertDialogAddMatricula(context);
          }
        },
        elevation: 10,
        child: Icon(Icons.add),
      ),
    );
  }
}
