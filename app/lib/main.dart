import 'package:app/models/disciplinas.dart';
import 'package:app/models/matricula.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/controllers/disciplinas_controllers.dart';
import 'package:app/controllers/monitoria_controllers.dart';
import 'package:app/controllers/user_controllers.dart';
import 'package:app/controllers/matricula_controllers.dart';
import 'package:app/screen/authentication/authenticate_screen.dart';

import 'package:app/screen/config/config_screen.dart';
import 'package:app/screen/matricula_screen.dart';
import 'package:app/screen/monitorias_screen.dart';

import 'package:app/screen/initial_screen.dart';
import 'package:app/screen/home_screen.dart';
import 'package:app/screen/authentication/register_screen.dart';
import 'package:app/screen/search_student_screen.dart';
import 'package:app/screen/user_screen.dart';

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
        catchError: (context, error) {
          return <Matricula>[];
        },
      ),
      FutureProvider<List<Disciplina>>.value(
        value: DisciplinaService.getDisciplinas(firestore: firestore),
        initialData: [],
        catchError: (context, error) {
          return <Disciplina>[];
        },
      ),
      FutureProvider<List<Monitoria>>.value(
        value: MonitoriasService.getAllMonitorias(firestore),
        initialData: [],
        catchError: (context, error) {
          return <Monitoria>[];
        },
      ),

      //substituindo o ChangeNotifierProvider deixando o listen = false
      ProxyProvider<List<Matricula>, MatriculaController>(
        update: (context, matriculas, previous) {
          previous ??= MatriculaController();
          previous.initializeMatriculas(matriculas);
          return previous;
        },
      ),
      ChangeNotifierProvider<UserController>(create: (_) => UserController()),
      ChangeNotifierProvider<MonitoriaController>(
          create: (_) => MonitoriaController()),
      ChangeNotifierProvider(create: (_) => DisciplinasController()),
    ],
    child: const USMApp(
      title: "MON. UERJ-ZO",
    ),
  ));
}

class USMApp extends StatelessWidget {
  const USMApp({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: USMThemeData.themeData,
      initialRoute: Routes.login,
      routes: {
        Routes.login: (context) => InitialScreen(),
        Routes.authenticate: (context) => AuthenticateScreen(),
        Routes.cadastro: (context) => RegisterScreen(),
        Routes.home: (context) => HomeScreen(
              key: Key('home_screen'),
              title: title,
            ),
        Routes.userScreen: (context) => UserScreen(),
        Routes.searchStudent: (context) => SearchStudentScreen(),
        Routes.monitorias: (context) => MonitoriasSreen(),
        Routes.matriculas: (context) => MatriculaScreen(),
        Routes.config: (context) => ConfigScreen(),
      },
    );
  }
}
