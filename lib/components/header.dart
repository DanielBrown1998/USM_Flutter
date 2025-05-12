import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({required super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          Radius.elliptical(16, 16),
        ),
        image: DecorationImage(
          image: AssetImage("lib/assets/images/back-720.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Image.asset("lib/assets/images/logomarca-uerj.png"),
    );
  }
}
