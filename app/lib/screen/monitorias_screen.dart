import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/monitoria_details.dart';
import 'package:app/services/firebase_service.dart';
import 'package:app/services/monitorias_service.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MonitoriasSreen extends StatefulWidget {
  const MonitoriasSreen({super.key});

  @override
  State<MonitoriasSreen> createState() => _MonitoriasSreenState();
}

class _MonitoriasSreenState extends State<MonitoriasSreen> {
  @override
  Widget build(BuildContext context) {
    loadData() async {
      FirebaseFirestore firestore = await FirebaseService.initializeFirebase();
      return await MonitoriasService.getAllMonitorias(firestore);
    }

    // List<Monitoria> monitorias = MonitoriasService.loadMonitorias();
    return Scaffold(
      backgroundColor: ThemeUSM.scaffoldBackgroundColor,
      appBar: USMAppBar.appBar(context, "Monitorias"),
      body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(child: Text("Erro ao carregar dados"));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MonitoriaDetails(monitoria: snapshot.data![index]);
                  });
            } else {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      size: 100,
                      color: Colors.red,
                    ),
                    Text(
                      "houve um erro desconhecido",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
