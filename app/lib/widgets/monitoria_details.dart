import 'package:app/models/monitoria.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MonitoriaDetails extends StatelessWidget {
  final Monitoria monitoria;
  const MonitoriaDetails({super.key, required this.monitoria});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeUSM.backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: ThemeUSM.backgroundColorWhite,
            child: Icon(
              Icons.person,
              color: ThemeUSM.backgroundColor,
            ),
          ),
          title: Text(
            monitoria.aluno,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          subtitle: Text(
            "${monitoria.date.day}/${monitoria.date.month}/${monitoria.date.year}",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Text(
            "status: ${monitoria.status}",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {}, // TODO create dialog for change status here
        ),
      ),
    );
  }
}
