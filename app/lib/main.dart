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
        cardColor: Color(0xFF2f4073),
        dividerColor: Color.fromARGB(255, 196, 8, 8),
        shadowColor: const Color(0xFFbfb6aa),
        primaryColorDark: Color(0xFF0e3659),
        primaryColor: Color(0xFFF2EDE4),
        scaffoldBackgroundColor: const Color(0xFF595959),
        useMaterial3: true,
      ),
      home: Home(
        key: Key('home_screen'),
        title: title,
      ),
    );
  }
}
