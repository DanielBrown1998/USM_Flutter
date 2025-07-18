import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/config_card.dart';
import 'package:app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/routes/routes.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: USMAppBar.appBar(context, "Configuracoes"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Header(key: Key("config_screen_header")),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConfigCard(
                  titleText: "Dias",
                  description: "Altere os dias da monitoria",
                  icon: Icons.calendar_today,
                  route: Routes.configDays,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConfigCard(
                  titleText: "Disciplinas",
                  description: "gerencie as monitorias (som. admin)",
                  icon: Icons.settings_applications,
                  route: Routes.configDisciplina,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConfigCard(
                  titleText: "Discentes",
                  description: "gerenciar usuarios",
                  icon: Icons.supervised_user_circle,
                  route: Routes.configUsuarios,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
