import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogoLaptop extends StatelessWidget {
  const LogoLaptop({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: "lottie-laptop",
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Lottie.asset("assets/loties/laptop.json"),
        ),
      ),
    );
  }
}
