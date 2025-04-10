import "package:app/screen/search_student_screen.dart";
import "package:flutter/material.dart";

class ListBody extends StatelessWidget {
  const ListBody({super.key});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> buttons = {
      "buscar alunos": SearchStudentScreen(),
      "update monitorias": null,
      "inserir matriculas": null,
      "resetar senha": null,
      "alterar dia da monitoria": null,
  };
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: buttons.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int i) {
        return Card(
          borderOnForeground: true,
          elevation: 10,
          child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
              MaterialPageRoute(builder: (context) => buttons.values.toList()[i]),);
              },
              splashColor: Theme.of(context).primaryColorDark,
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                buttons.keys.toList()[i],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).primaryColor,
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

class MonitoriaView extends StatelessWidget {
  MonitoriaView({super.key});

  final List<dynamic> listMonitorias = <dynamic>[
    "monitoria 1",
    "monitoria 2",
    "monitoria 3",
    "monitoria 4",
    "monitoria 5",
    "monitoria 6",
    "monitoria 7",
    "monitoria 8",
    "monitoria 9",
    "monitoria 10",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: listMonitorias.length,
          itemBuilder: (context, int i) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${listMonitorias[i]}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check,
                        color: Theme.of(context).primaryColor),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).dividerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Icon(Icons.delete,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  ),
                ])
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Theme.of(context).dividerColor,
              height: 2,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            );
          },
        ),
      ),
    );
  }
}
