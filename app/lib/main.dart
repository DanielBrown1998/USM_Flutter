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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(
        key: Key('home_screen'),
        title: title,
      ),
    );
  }
}
