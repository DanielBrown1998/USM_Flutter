import 'package:app/models/days.dart';
import 'package:app/models/matricula.dart';
import 'package:app/models/objects/monitoria_objects.dart';

import 'package:app/models/objects/data_user_objects.dart';
import 'package:app/models/objects/days_objects.dart';
import 'package:app/models/objects/matricula_objects.dart';
import 'package:app/models/objects/user_objects.dart';

import 'package:app/services/days_service.dart';
import 'package:app/services/matricula_service.dart';

import 'package:app/screen/login.dart';
import 'package:app/screen/home_screen.dart';
import 'package:app/screen/search_student_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/theme/theme.dart';
import 'package:provider/provider.dart';
import "package:app/services/firebase_service.dart" as firebase;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // -> porque a main agora e assincrona

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // firestore.collection("teste").doc("testando").set({"work?": true});

  //TODO: inserir isso em um shared preferences
  // firestore.collection("matriculas").doc("matricula").get().then(
  // (value) => print("${value.data()} - ${value.data().runtimeType}"));

  FirebaseFirestore firestore =
      await firebase.FirebaseService.initializeFirebase();
  List<Matricula> matriculas = await MatriculaService.takeMatriculas(firestore);
  List<Days> days = await DaysService.takeDays(firestore);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => MatriculaObjects(matriculas: matriculas)),
      ChangeNotifierProvider(create: (_) => UserObjects()),
      ChangeNotifierProvider(create: (_) => DaysObjects(days: days)),
      ChangeNotifierProvider(
          create: (_) => DataUserObjects()),
      ChangeNotifierProvider(create: (_) => MonitoriaObjects()),

    ],
    child: const MyApp(
      title: "MON. UERJ-ZO",
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.title});
  final String title;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardColor: ThemeUSM.cardColor,
        dividerColor: ThemeUSM.dividerDrawerColor,
        shadowColor: ThemeUSM.shadowColor,
        primaryColor: ThemeUSM.textColor,
        scaffoldBackgroundColor: ThemeUSM.scaffoldBackgroundColor,
        drawerTheme: DrawerThemeData(
          backgroundColor: ThemeUSM.backgroundColor,
          elevation: 10,
        ),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: ThemeUSM.textColor,
              applyTextScaling: true,
            ),
            actionsIconTheme: IconThemeData(applyTextScaling: true),
            backgroundColor: ThemeUSM.backgroundColor,
            elevation: 20,
            titleTextStyle: TextStyle(color: ThemeUSM.textColor)),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ThemeUSM.buttonColor,
            secondary: ThemeUSM.textColor,
          ),
          buttonColor: ThemeUSM.buttonColor,
        ),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              fontFamily: "Ubuntu",
              fontSize: 22,
            ),
            displayMedium: TextStyle(fontFamily: "Ubuntu", fontSize: 18),
            displaySmall: TextStyle(fontFamily: "Ubuntu", fontSize: 14)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Login(),
        "/home": (context) => Home(
              key: Key('home_screen'),
              title: title,
            ),
        "/search_student": (context) => SearchStudentScreen(),
      },
    );
  }
}
