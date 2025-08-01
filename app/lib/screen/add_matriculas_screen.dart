import 'package:app/controllers/matricula_controllers.dart';
import 'package:app/models/disciplinas.dart';
import 'package:app/models/matricula.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/forms/drop_down_button_campus.dart';
import 'package:app/widgets/forms/show_disciplinas_at_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMatriculasScreen extends StatefulWidget {
  const AddMatriculasScreen({super.key});

  @override
  State<AddMatriculasScreen> createState() => _AddMatriculasScreenState();
}

class _AddMatriculasScreenState extends State<AddMatriculasScreen> {
  final _formKey = GlobalKey<FormState>();
  // Os controladores e as listas de estado devem ser declarados aqui, fora do método build.
  final _matriculaController = TextEditingController();
  String? _selectedCampus;
  List<Disciplina> _selectedDisciplinas = [];

  @override
  void dispose() {
    // É uma boa prática descartar os controladores quando o widget for removido.
    _matriculaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final media = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: USMAppBar.appBar(context, "Add Matricula"),
      body: SingleChildScrollView(
        child: Consumer<MatriculaController>(
          builder: (context, value, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          spacing: 2,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Insira a matricula do Aluno: ",
                              style: theme.textTheme.bodyMedium,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "a matricula e obrigatoria";
                                  }
                                  if (value.length != 12) {
                                    return "a matricula deve possuir 12 algarismos";
                                  }
                                  return null;
                                },
                                controller: _matriculaController,
                                decoration: InputDecoration(
                                  hintText: "Insira a matricula",
                                  hintStyle: theme.textTheme.bodySmall,
                                  icon: Icon(
                                      Icons.keyboard_double_arrow_right_sharp),
                                  label: Text(
                                    "matricula",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ShowDisciplinasAtRadioButton(
                      // Atribui a lista de disciplinas selecionadas à variável de estado.
                      onDisciplinasChanged: (List<Disciplina> disciplinas) {
                        _selectedDisciplinas = disciplinas;
                      },
                    ),
                    DropDownButtonCampus(
                      // Atribui o campus selecionado à variável de estado.
                      onCampusChanged: (String? campus) {
                        _selectedCampus = campus;
                      },
                    ),
                    FilledButton(
                      style:
                          ButtonStyle(visualDensity: VisualDensity.comfortable),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (value.getMatricula(_matriculaController.text) !=
                              null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("matricula JA cadastrada!!!")));
                          } else {
                            Matricula matricula = Matricula(
                                disciplinas: _selectedDisciplinas,
                                matricula: _matriculaController.text,
                                campus: _selectedCampus!);
                            bool isAdd = await value.setMatricula(matricula);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text((isAdd)
                                    ? "matricula ${matricula.matricula} cadastrada com sucesso!"
                                    : "Houve um erro, tente novamente mais tarde!")));
                          }
                        }
                      },
                      child: Text(
                        "adicionar",
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
