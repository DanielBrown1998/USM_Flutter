import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/header.dart';
import 'package:app/widgets/alert_dialog.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _matricula = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: USMAppBar.appBar(context, "Buscar Aluno"),
      body: Column(
          spacing: 5.5,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Header(
                key: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).primaryColor,
                ),
                child: SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Insira os Dados",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _name,
                                decoration: InputDecoration(labelText: "Nome"),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                              TextFormField(
                                controller: _matricula,
                                decoration:
                                    InputDecoration(labelText: "Matricula"),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                              TextFormField(
                                controller: _email,
                                decoration: InputDecoration(labelText: "email"),
                                validator: (value) {
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: Material(
                                    color: ThemeUSM.blackColor,
                                    animationDuration: Duration(seconds: 1),
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(4, 2)),
                                    elevation: 10,
                                    child: InkWell(
                                      onTap: () async {
                                        final String name = _name.text;
                                        final String email = _email.text;
                                        final String matricula =
                                            _matricula.text;
                                        if (name == "" &&
                                            email == "" &&
                                            matricula == "") {
                                          await alertDialogStudent(context,
                                              title: "Atencao",
                                              msg: "preencha algum campo!!!",
                                              confirmation: "sim",
                                              cancel: "nao",
                                              icon: Icons.dangerous_outlined);
                                          return;
                                        }
                                        // print("$name $email $matricula");
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "buscar",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
    );
  }
}
