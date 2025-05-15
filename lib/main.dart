import 'package:app/models/data_user.dart';
import 'package:app/models/days.dart';
import 'package:app/models/matricula.dart';
import 'package:app/models/objects/data_user_objects.dart';
import 'package:app/models/objects/days_objects.dart';
import 'package:app/models/objects/matricula_objects.dart';
import 'package:app/models/objects/monitoria_objects.dart';
import 'package:app/models/objects/user_objects.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/models/user.dart';
import 'package:app/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/screen/home_screen.dart';
import 'package:app/screen/search_student_screen.dart';
import 'package:app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // -> porque a main agora e assincrona

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  User userRoot = User(
      email: "daniel@xpto.com",
      firstName: "Daniel",
      lastName: "Passos",
      userName: "202213313611",
      password: "hash123",
      isStaff: true,
      isSuperUser: true,
      isActive: true,
      dateJoined: DateTime.now(),
      lastLogin: DateTime.now());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => UserObjects(user: [
                userRoot,
              ])),
      ChangeNotifierProvider(
          create: (_) => MatriculaObjects(matriculas: [
                Matricula(matricula: '202213313611', id: '01'),
              ])),
      ChangeNotifierProvider(create: (_) => MonitoriaObjects(monitoria: [])),
      ChangeNotifierProvider(
          create: (_) => DataUserObjects(dataUser: [
                DataUser(
                    owner: userRoot,
                    monitoriasPresentes: 0,
                    monitoriasAusentes: 0,
                    monitoriasMarcadas: 0,
                    monitoriasCanceladas: 0,
                    phone: '21999998888'),
              ])),
      ChangeNotifierProvider(
          create: (_) => DaysObjects(days: [
                Days(days: "segunda-feira"),
                Days(days: "terca-feira"),
                Days(days: "quinta-feira"),
                Days(days: "sexta-feira"),
              ])),
    ],
    child: const MyApp(
      title: "MON. UERJ-ZO",
    ),
  ));

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection("teste").doc("testando").set({"work?": true});
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
