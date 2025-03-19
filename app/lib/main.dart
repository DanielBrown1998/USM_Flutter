import 'package:flutter/material.dart';
import 'package:app/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp(
    title: "MON. UERJ-ZO",
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
      theme: ThemeData(
        cardColor: Color(0xFF403B25),
        dividerColor: Colors.black26,
        shadowColor: const Color(0xFFA69A60),
        primaryColorDark: Color(0xFFF2E088),
        primaryColor: Color(0xFF0D0D0D),
        scaffoldBackgroundColor: const Color.fromARGB(199, 129, 125, 103),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF2E088),
            primary: const Color(0xFF403B25),),
        useMaterial3: true,
      ),
      home: Home(
        key: Key('home_screen'),
        title: title,
      ),
    );
  }
}
