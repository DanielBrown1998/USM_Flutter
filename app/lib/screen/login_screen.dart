import 'package:app/components/logo_laptop.dart';
import 'package:app/models/matricula.dart';
import 'package:app/models/settings/matricula_settings.dart';
import 'package:app/models/settings/user_settings.dart';
import 'package:app/services/firebase_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/utils/routes/routes.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _op = 0.0;
  double bottomPadding = 48;
  MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.center;
  TextEditingController matriculaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    awaitAndSet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  awaitAndSet() async {
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      _op = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUSM.backgroundColor,
      body: Consumer<MatriculaSettings>(
          builder: (context, MatriculaSettings list, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeUSM.backgroundColorWhite,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                curve: Curves.easeInCubic,
                opacity: _op,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "USM",
                    style: TextStyle(
                        color: ThemeUSM.textColor,
                        decorationStyle: TextDecorationStyle.solid,
                        fontFamily: "Ubuntu",
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              LogoLaptop(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: _op,
                curve: Curves.easeInCubic,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 40,
                    children: [
                      Material(
                        color: ThemeUSM.backgroundColor,
                        child: TextFormField(
                          style: TextStyle(
                              color: ThemeUSM.textColor,
                              fontSize: 16,
                              fontFamily: "Ubuntu",
                              fontStyle: FontStyle.italic),
                          controller: matriculaController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            labelText: "Matricula",
                            icon: Icon(Icons.login),
                            iconColor: ThemeUSM.textColor,
                            helperText: "Insira sua matricula",
                            helperStyle: TextStyle(
                                color: ThemeUSM.textColor,
                                fontSize: 12,
                                fontFamily: "Ubuntu"),
                            constraints: BoxConstraints(
                                minHeight: 60,
                                maxHeight: 120,
                                minWidth: double.maxFinite),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () async {
                                Matricula? matricula =
                                    list.getMatricula(matriculaController.text);
                                if (matricula != null) {
                                  //substituir pela Authenticacao
                                  if (!context.mounted) return;
                                  var users = Provider.of<UserSettings>(context,
                                      listen: false);
                                  try {
                                    FirebaseFirestore firestore =
                                        await FirebaseService
                                            .initializeFirebase();
                                    users.user =
                                        await UserService.getUserByMatricula(
                                            firestore: firestore,
                                            matricula: matricula.matricula);
                                  } on UserNotFoundException catch (_) {
                                    users.user = null;
                                    if (users.user == null) {
                                      users.matricula = matricula;
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Usuario nao encontrado!",
                                            style: TextStyle(
                                                color: ThemeUSM.textColor,
                                                fontSize: 16),
                                          ),
                                          backgroundColor:
                                              ThemeUSM.backgroundColor,
                                        ),
                                      );
                                      //redirect to signin screen
                                      Navigator.of(context)
                                          .pushNamed(Routes.cadastro);
                                    } else {
                                      //redirect to login screen
                                      if (!context.mounted) return;
                                      Navigator.of(context)
                                          .popAndPushNamed(Routes.home);
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Matricula não encontrada",
                                        style: TextStyle(
                                            color: ThemeUSM.textColor,
                                            fontSize: 16),
                                      ),
                                      backgroundColor: ThemeUSM.backgroundColor,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "entrar",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: ThemeUSM.textColor,
                                    fontSize: 20),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
