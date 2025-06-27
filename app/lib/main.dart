import 'package:app/models/disciplinas.dart';
import 'package:app/models/matricula.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/settings/disciplinas_settings.dart';
import 'package:app/models/settings/monitoria_settings.dart';
import 'package:app/models/settings/user_settings.dart';
import 'package:app/models/settings/days_settings.dart';
import 'package:app/models/settings/matricula_settings.dart';

import 'package:app/screen/config_screen.dart';
import 'package:app/screen/matricula_screen.dart';
import 'package:app/screen/monitorias_screen.dart';

import 'package:app/screen/login_screen.dart';
import 'package:app/screen/home_screen.dart';
import 'package:app/screen/search_student_screen.dart';

import "package:app/services/firebase_service.dart" as firebase;
import 'package:app/services/matricula_service.dart';
import "package:app/services/disciplina_service.dart";
import 'package:app/services/monitorias_service.dart';

import 'package:app/utils/theme/theme.dart';
import 'package:app/utils/routes/routes.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // -> porque a main agora e assincrona
  Provider.debugCheckInvalidValueType = null;

  FirebaseFirestore firestore =
      await firebase.FirebaseService.initializeFirebase();

  runApp(MultiProvider(
    providers: [
      FutureProvider<List<Matricula>>.value(
        value: MatriculaService.getAllMatriculas(firestore),
        initialData: [],
      ),
      FutureProvider<List<Disciplinas>>.value(
        value: DisciplinaService.getDisciplinasIDs(firestore: firestore),
        initialData: [],
      ),
      FutureProvider<List<Monitoria>>.value(
        value: MonitoriasService.getAllMonitorias(firestore),
        initialData: [],
      ),

      //substituindo o ChangeNotifierProvider deixando o listen = false
      ProxyProvider<List<Matricula>, MatriculaSettings>(
        update: (context, matriculas, previous) {
          previous ??= MatriculaSettings();
          previous.initializeMatriculas(matriculas);
          return previous;
        },
      ),
      ChangeNotifierProvider<UserSettings>(create: (_) => UserSettings()),
      ChangeNotifierProvider<DaysSettings>(create: (_) => DaysSettings()),
      ChangeNotifierProvider<MonitoriaSettings>(
          create: (_) => MonitoriaSettings()),
      ChangeNotifierProvider(create: (_) => DisciplinasSettings()),
    ],
    child: const USMApp(
      title: "MON. UERJ-ZO",
    ),
  ));
}

class USMApp extends StatelessWidget {
  const USMApp({super.key, required this.title});
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
        Routes.config: (context) => ConfigScreen(),
      },
    );
  }
}
