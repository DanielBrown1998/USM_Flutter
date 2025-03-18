import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({required super.key});

  @override
  Widget build(BuildContext context) {
    int num = 0;
    String aluno = "Daniel Brown";
    String disciplina = "Arquitetura de computadores";
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nome: $aluno"),
                Text("monitorias marcadas: $num"),
                Text("disciplina: $disciplina"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
