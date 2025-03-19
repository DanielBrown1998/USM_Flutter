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
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.elliptical(16, 16),
        ),
        image: DecorationImage(
          image: AssetImage("lib/assets/images/back-720.png"),
          fit: BoxFit.cover,
        ),
        
      ),
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
                Text(
                  "MONITOR: $aluno",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "MONITORIAS HOJE: $num",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "DISCIPLINA: $disciplina",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
