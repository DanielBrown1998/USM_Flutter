import 'package:app/core/routes/routes.dart';
import 'package:app/screen/widgets/appbar.dart';
import 'package:app/screen/widgets/header.dart';
import 'package:app/controllers/matricula_controllers.dart';
import 'package:app/domain/models/matricula.dart';
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
    final theme = Theme.of(context);
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
            child: Consumer<MatriculaController>(
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              background: Container(
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.primary),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    spacing: 5,
                                    children: [
                                      Text(
                                        "atualizar",
                                        style: theme.textTheme.displaySmall,
                                      ),
                                      Icon(
                                        Icons.update,
                                        color: theme.primaryColor,
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              direction: DismissDirection.endToStart,
                              key: Key(data.matricula),
                              child: ListTile(
                                leading: Icon(Icons.arrow_back_sharp),
                                tileColor: theme.primaryColor,
                                onTap: () {},
                                title: Text(data.matricula),
                                subtitle: Text(
                                    "numero de disciplinas: ${data.disciplinas.length.toString()}"),
                              ),
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
        backgroundColor: theme.primaryColor,
        onPressed: () async {
          if (context.mounted) {
            await Navigator.pushNamed(context, Routes.addMatriculas);
          }
        },
        elevation: 10,
        child: Icon(Icons.add),
      ),
    );
  }
}
