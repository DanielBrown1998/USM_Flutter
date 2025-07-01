import 'package:app/components/alert_dialog.dart';
import 'package:app/models/monitoria.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MonitoriaCard extends StatelessWidget {
  final Monitoria monitoria;

  const MonitoriaCard({super.key, required this.monitoria});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          // border: Border.all(color: ThemeUSM.backgroundColor),
          // borderRadius: BorderRadius.all(Radius.elliptical(4, 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    monitoria.userName,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: ThemeUSM.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto",
                    ),
                  ),
                  Text(
                    "${monitoria.date.day}-${monitoria.date.month}-${monitoria.date.year}",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: ThemeUSM.backgroundColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Roboto",
                    ),
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //confirmation button
                IconButton(
                  onPressed: () async {
                    bool value = await alertDialogStatusMonitoria(context,
                        icon: Icons.dangerous_outlined,
                        title: "Alterar Status Monitoria",
                        confirmation: "sim",
                        cancel: "nao",
                        description:
                            "deseja alterar o status da msg para concluido",
                        monitoriaMarcada: monitoria);
                    if (value == true) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "${monitoria.userName} realizou a monitoria!")));
                    } else if (value == false) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              " status nao alterado para ${monitoria.userName}")));
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erro: ${value.toString()}")));
                    }
                  },
                  icon: Icon(Icons.check, color: ThemeUSM.textColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeUSM.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                //no confirmation button
                IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).dividerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon:
                      Icon(Icons.delete, color: Theme.of(context).primaryColor),
                  onPressed: () async {
                    bool value = await alertDialogStatusMonitoria(context,
                        icon: Icons.dangerous_outlined,
                        title: "Alterar Status Monitoria",
                        confirmation: "sim",
                        cancel: "nao",
                        description:
                            "deseja alterar o status da msg para nao concluido",
                        monitoriaMarcada: monitoria,
                        monitoriaOk: false);
                    if (value == true) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              " ${monitoria.userName} nao realizou a monitoria")));
                    } else if (value == false) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              " status nao alterado para ${monitoria.userName}")));
                    } else {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erro: ${value.toString()}")));
                    }
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
