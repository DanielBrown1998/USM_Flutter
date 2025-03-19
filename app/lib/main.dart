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
        cardColor: Color(0xFFBAF266),
        dividerColor: Color(0xFF0D0D0D),
        shadowColor: const Color(0xFFD6F272),
        primaryColorDark: Color(0xFF595959),
        primaryColor: Color.fromARGB(255, 162, 162, 162),
        scaffoldBackgroundColor: const Color(0xFF595959),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6F8C42),
            primary: const Color(0xFF595959),),
        useMaterial3: true,
      ),
      home: Home(
        key: Key('home_screen'),
        title: title,
      ),
    );
  }
}
