import "package:flutter/material.dart";

class ListBody {
  static Widget list(BuildContext context) {
    List<String> nameButtons = <String>[
      "buscar alunos",
      "update monitorias",
      "inserir matriculas",
      "resetar senha",
      "alterar dia da monitoria",
      "monitorias hoje"
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: nameButtons.length,
      itemBuilder: (context, int i) {
        return Card(
          borderOnForeground: true,
          elevation: 10,
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 4,
              ),
            ),
            child: MaterialButton(
              onPressed: () {},
              splashColor: Theme.of(context).primaryColor,
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                nameButtons[i],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Roboto",
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
