import 'package:app/components/appbar.dart';
import 'package:app/components/logo_laptop.dart';
// import 'package:app/models/matricula.dart';
import 'package:app/models/settings/user_settings.dart';
// import 'package:app/services/firebase_service.dart';
// import 'package:app/services/user_service.dart';
// import 'package:app/utils/routes/routes.dart';
import 'package:app/utils/theme/theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  double _op = 0.0;
  bool visiblePassword = false;
  double bottomPadding = 48;
  MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.center;
  TextEditingController passwordController = TextEditingController();

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ThemeUSM.backgroundColor,
      appBar: USMAppBar.appBar(context, "Login"),
      body:
          Consumer<UserSettings>(builder: (context, UserSettings user, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: _op,
                  curve: Curves.easeInCubic,
                  child: Text(
                    "Bem vindo(a), ${user.user!.firstName} ${user.user!.lastName}",
                    style: theme.textTheme.displayLarge,
                  ),
                ),
                LogoLaptop(),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 2000),
                  opacity: _op,
                  curve: Curves.easeInCubic,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: theme.colorScheme.onPrimaryContainer),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Text(
                        "Realize seu Login",
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 40,
                    children: [
                      Hero(
                        tag: "matricula",
                        child: Material(
                          color: ThemeUSM.backgroundColor,
                          child: TextFormField(
                            style: theme.textTheme.displayMedium,
                            enabled: false,
                            initialValue: user.matricula!.matricula,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              labelText: "Matricula",
                              icon: Icon(Icons.login),
                              iconColor: ThemeUSM.textColor,
                              helperText: "Matricula encontrada!",
                              helperStyle: theme.textTheme.displaySmall,
                              constraints: BoxConstraints(
                                  minHeight: 60,
                                  maxHeight: 120,
                                  minWidth: double.maxFinite),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Material(
                              color: ThemeUSM.backgroundColor,
                              child: TextFormField(
                                style: theme.textTheme.displayMedium,
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                textAlign: TextAlign.center,
                                maxLength: 20,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  floatingLabelStyle:
                                      theme.textTheme.displaySmall,
                                  icon: Icon(Icons.password),
                                  iconColor:
                                      theme.colorScheme.onPrimaryContainer,
                                  helperText: "Digite sua senha!",
                                  helperStyle: theme.textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visiblePassword = !visiblePassword;
                                  });
                                },
                                icon: Icon(
                                  (!visiblePassword)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: theme.colorScheme.onPrimaryContainer,
                                )),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              //firebase authenticate!
                            },
                            child: Card(
                              elevation: 10,
                              shape: StadiumBorder(),
                              margin: EdgeInsets.all(2),
                              shadowColor: theme.colorScheme.onPrimaryContainer,
                              color: theme.colorScheme.onPrimaryContainer,
                              child: InkWell(
                                splashColor: theme.colorScheme.onPrimaryFixed,
                                child: Ink(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    "Entrar",
                                    style: theme.textTheme.displayLarge,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
