import 'package:app/controllers/disciplinas_controllers.dart';
import 'package:app/controllers/user_controllers.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:app/screen/widgets/appbar.dart';
import 'package:app/screen/widgets/cards/matricula_card.dart';
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
  bool monitorHasDisciplina = true;

  Future<List<Matricula>> getMatriculasRegisterdInDisciplineOfMonitor(
      Matricula matriculaOdMonitor,
      MatriculaController controller,
      DisciplinasController controllerDisciplina) async {
    Disciplina? disciplinaOFMonitor;

    for (Disciplina disciplina in controllerDisciplina.disciplinas) {
      if (disciplina.monitor == matriculaOdMonitor.matricula) {
        disciplinaOFMonitor = disciplina;
      }
    }
    if (disciplinaOFMonitor == null) {
      setState(() {
        monitorHasDisciplina = false;
      });
      return [];
    }

    List<Matricula> allMatriculas = await controller.getAllMatriculas();
    List<Matricula> matriculaRegisteredInDisciplineOfMonitor = [];
    for (Matricula matricula in allMatriculas) {
      if (matricula.disciplinas.contains(disciplinaOFMonitor)) {
        matriculaRegisteredInDisciplineOfMonitor.add(matricula);
      }
    }
    return matriculaRegisteredInDisciplineOfMonitor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    MatriculaController matriculaController =
        Provider.of<MatriculaController>(context, listen: false);
    DisciplinasController disciplinasController =
        Provider.of<DisciplinasController>(context, listen: false);
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
            child: Consumer<UserController>(
              builder: (context, value, child) {
                return FutureBuilder(
                  future: getMatriculasRegisterdInDisciplineOfMonitor(
                      value.matricula!,
                      matriculaController,
                      disciplinasController),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.no_accounts),
                              Text(
                                "Sem matriculas na sua disciplina",
                                style: theme.textTheme.bodyMedium,
                              )
                            ],
                          ),
                        );
                      } else if (!monitorHasDisciplina) {
                        return Center(
                          child: Column(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.no_accounts),
                              Text(
                                "Voce esta como membro da equipe, mas nao esta inscrito como monitor!",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        key: Key("list_matriculas"),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Matricula data = snapshot.data![index];
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MatriculaCard(
                                matricula: data,
                                matriculaController: matriculaController,
                              ));
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
        backgroundColor: ThemeUSM.purpleUSMColor,
        splashColor: ThemeUSM.cardColor,
        isExtended: true,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
            side: BorderSide(color: ThemeUSM.blackColor, width: 2)),
        onPressed: () async {
          if (context.mounted) {
            await Navigator.pushNamed(context, Routes.addMatriculas);
          }
        },
        elevation: 10,
        child: Icon(
          Icons.add,
          color: ThemeUSM.whiteColor,
        ),
      ),
    );
  }
}
