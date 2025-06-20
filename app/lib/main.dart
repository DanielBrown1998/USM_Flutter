import 'package:app/models/days.dart';
import 'package:app/models/matricula.dart';
import 'package:app/controllers/monitoria_objects.dart';

import 'package:app/controllers/days_objects.dart';
import 'package:app/controllers/matricula_objects.dart';

import 'package:app/controllers/user_objects.dart';
import 'package:app/screen/matricula_screen.dart';
import 'package:app/screen/monitorias.dart';

import 'package:app/services/days_service.dart';
import 'package:app/services/matricula_service.dart';

import 'package:app/screen/login.dart';
import 'package:app/screen/home_screen.dart';
import 'package:app/screen/search_student_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:app/utils/routes/routes.dart';
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
      theme: USMThemeData.themeData,
      initialRoute: Routes.login,
      routes: {
        Routes.login: (context) => Login(),
        Routes.home: (context) => Home(
              key: Key('home_screen'),
              title: title,
            ),
        Routes.searchStudent: (context) => SearchStudentScreen(),
        Routes.monitorias: (context) => MonitoriasSreen(),
        Routes.matriculas: (context) => MatriculaScreen(),
      },
    );
  }
}
