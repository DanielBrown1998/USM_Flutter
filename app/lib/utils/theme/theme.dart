import 'package:flutter/material.dart';

class ThemeUSM {
  static Color buttonColor = Color(0xFF2f4073);
  static Color textColor = Color.fromARGB(255, 213, 206, 194);
  static Color scaffoldBackgroundColor = Color.fromARGB(255, 228, 228, 228);
  static Color backgroundColor = const Color.fromARGB(214, 0, 0, 0);
  static Color cardColor = Color.fromARGB(255, 85, 104, 161);
  static Color dividerDrawerColor = Color.fromARGB(255, 130, 7, 230);
  static Color shadowColor = Color.fromARGB(255, 201, 199, 198);
  static Color backgroundColorWhite = Colors.white12;
}

class USMThemeData {
  static ThemeData themeData = ThemeData(
    cardColor: ThemeUSM.cardColor,
    dividerColor: ThemeUSM.dividerDrawerColor,
    shadowColor: ThemeUSM.shadowColor,
    primaryColor: ThemeUSM.textColor,
    scaffoldBackgroundColor: ThemeUSM.scaffoldBackgroundColor,
    drawerTheme: USMDrawerTheme.drawerTheme,
    appBarTheme: USMAppBarTheme.appBarTheme,
    buttonTheme: USMButtonThemeData.buttonThemeData,
    textTheme: USMThemeText.textTheme,
    useMaterial3: true,
  );
}

class USMDrawerTheme {
  static DrawerThemeData drawerTheme = DrawerThemeData(
    backgroundColor: ThemeUSM.backgroundColor,
    elevation: 10,
  );
}

class USMAppBarTheme {
  static AppBarTheme appBarTheme = AppBarTheme(
      iconTheme: IconThemeData(
        color: ThemeUSM.textColor,
        applyTextScaling: true,
      ),
      actionsIconTheme: IconThemeData(applyTextScaling: true),
      backgroundColor: ThemeUSM.backgroundColor,
      elevation: 20,
      titleTextStyle: TextStyle(color: ThemeUSM.textColor));
}

class USMButtonThemeData {
  static ButtonThemeData buttonThemeData = ButtonThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: ThemeUSM.buttonColor,
      secondary: ThemeUSM.textColor,
    ),
    buttonColor: ThemeUSM.buttonColor,
  );
}

class USMThemeText {
  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontFamily: "Ubuntu", fontSize: 22, color: ThemeUSM.textColor),
    displayMedium: TextStyle(
        fontFamily: "Ubuntu", fontSize: 18, color: ThemeUSM.textColor),
    displaySmall: TextStyle(
        fontFamily: "Ubuntu", fontSize: 14, color: ThemeUSM.textColor),
  );
}
