import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _op = 0.0;
  double bottomPadding = 48;
  MainAxisAlignment columnMainAxisAlignment = MainAxisAlignment.center;
  TextEditingController matricula = TextEditingController();

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
    return AnimatedPadding(
      duration: Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      padding:
          EdgeInsets.only(top: 48, bottom: 40, left: 16, right: 16),
      child: Container(
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
                padding: const EdgeInsets.all(24.0),
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
            Lottie.asset(
              "lib/assets/loties/laptop.json",
            ),
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
                        controller: matricula,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Matricula",
                          icon: Icon(Icons.login),
                          iconColor: ThemeUSM.textColor,
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
                            onPressed: () {
                              Navigator.of(context).pushNamed("/home");
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
      ),
    );
  }
}
