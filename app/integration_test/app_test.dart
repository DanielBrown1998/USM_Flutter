import "package:app/components/drawer.dart";
import "package:app/components/header.dart";
import "package:app/components/body.dart" as custom_body;
import "package:app/components/monitoria_card.dart";
import "package:app/components/monitoria_details.dart";
import "package:app/main.dart";
import "package:app/models/disciplinas.dart";
import "package:app/models/matricula.dart";
import "package:app/models/monitoria.dart";

import "package:app/models/settings/disciplinas_settings.dart";
import "package:app/models/settings/matricula_settings.dart";
import "package:app/models/settings/monitoria_settings.dart";
import "package:app/models/settings/user_settings.dart";
import "package:app/services/disciplina_service.dart";
import "package:app/services/matricula_service.dart";
import "package:app/services/monitorias_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:date_field/date_field.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:lottie/lottie.dart";
import "package:provider/provider.dart";
import "package:app/services/firebase_service.dart" as firebase;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("fluxo de Telas", () {
    setUpAll(() async {});

    testWidgets("testando telas e seus componentes", (test) async {
      Provider.debugCheckInvalidValueType = null;

      const String matricula = "202213313611";
      FirebaseFirestore firestore =
          await firebase.FirebaseService.initializeFirebase();

      await test.pumpWidget(MultiProvider(
        providers: [
          FutureProvider<List<Matricula>>.value(
            value: MatriculaService.getAllMatriculas(firestore),
            initialData: [],
          ),
          FutureProvider<List<Disciplinas>>.value(
            value: DisciplinaService.getDisciplinas(firestore: firestore),
            initialData: [],
          ),
          FutureProvider<List<Monitoria>>.value(
            value: MonitoriasService.getAllMonitorias(firestore),
            initialData: [],
          ),

          //substituindo o ChangeNotifierProvider deixando o listen = false
          ProxyProvider<List<Matricula>, MatriculaSettings>(
            update: (context, matriculas, previous) {
              previous ??= MatriculaSettings();
              previous.initializeMatriculas(matriculas);
              return previous;
            },
          ),
          ChangeNotifierProvider<UserSettings>(create: (_) => UserSettings()),
          ChangeNotifierProvider<MonitoriaSettings>(
              create: (_) => MonitoriaSettings()),
          ChangeNotifierProvider(create: (_) => DisciplinasSettings()),
        ],
        child: const USMApp(
          title: "MON. UERJ-ZO Test",
        ),
      ));
      await test.pumpAndSettle();

      //verificando a tela de login
      expect(find.text("USM"), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text("entrar"), findsOneWidget);

      await test.enterText(find.byType(TextFormField), matricula);
      await test.pumpAndSettle();
      await test.tap(find.text("entrar"));
      await test.pumpAndSettle();

      final buscarAlunosScreen = find.text("buscar alunos");
      final matriculasScreen = find.text("matriculas");
      final monitoriasScreen = find.text("monitorias");
      final configScreen = find.text("config");
      final elevatedButtonAddMonitoria = find.byKey(Key("add_monitoria"));
      final listScreensInHome = find.byType(custom_body.ListBody);
      final monitoriasMarcadasView = find.byType(custom_body.MonitoriaView);
      final monitoriaMarcada = find.byType(MonitoriaCard);

      //verificando a home
      expect(find.byType(Header), findsOneWidget);
      expect(listScreensInHome, findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(monitoriasMarcadasView, findsOneWidget);
      expect(monitoriaMarcada, findsWidgets);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      expect(buscarAlunosScreen, findsOneWidget);
      expect(matriculasScreen, findsOneWidget);
      expect(monitoriasScreen, findsOneWidget);

      await test.drag(find.byType(custom_body.ListBody), Offset(-1000, 0));
      await test.pumpAndSettle();

      expect(configScreen, findsOneWidget);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      await test.tap(elevatedButtonAddMonitoria);
      await test.pumpAndSettle(Duration(seconds: 2));

      //verificando a adicao de monitoria
      expect(find.text("Add Monitoria"), findsOneWidget);
      expect(find.byKey(Key("add_monitoria_image")), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DateTimeFormField), findsOneWidget);
      var iconWidgetRemoveAlertDialog =
          find.byIcon(Icons.highlight_remove_sharp);
      expect(iconWidgetRemoveAlertDialog, findsOneWidget);

      //saindo do dialog
      await test.tap(iconWidgetRemoveAlertDialog);
      await test.pumpAndSettle();

      //verificando se saiu do alertdialog de addmonitoria
      expect(find.text("Add Monitoria"), findsNothing);
      expect(find.byKey(Key("add_monitoria_image")), findsNothing);
      expect(find.byType(TextFormField), findsNothing);

      //entrando no Drawer
      expect(find.byIcon(Icons.menu), findsWidgets);
      await test.tap(find.byIcon(Icons.menu));
      await test.pumpAndSettle();

      expect(find.byType(DrawerHeader), findsOneWidget);
      expect(find.byType(ListTileWidget), findsNWidgets(6));

      final buttonBackDrawer = find.byKey(Key("back_drawer"));
      expect(buttonBackDrawer, findsOneWidget);

      //saindo do drawer
      await test.tap(buttonBackDrawer);
      await test.pumpAndSettle();
      expect(find.byType(DrawerHeader), findsNothing);

      //verificando a home
      expect(find.byType(Header), findsOneWidget);
      expect(listScreensInHome, findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(monitoriasMarcadasView, findsOneWidget);
      expect(monitoriaMarcada, findsWidgets);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      await test.drag(listScreensInHome, Offset(1000, 0));
      await test.pumpAndSettle();
      expect(buscarAlunosScreen, findsOneWidget);
      expect(matriculasScreen, findsOneWidget);
      expect(monitoriasScreen, findsOneWidget);

      await test.drag(listScreensInHome, Offset(-1000, 0));
      await test.pumpAndSettle();

      expect(configScreen, findsOneWidget);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      //emtrando na screen matriculas
      await test.tap(matriculasScreen);
      await test.pumpAndSettle();

      expect(find.byKey(Key(matricula)), findsOneWidget);
      expect(find.byType(Header), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      //TODO verificar a adicao de matriculas

      //saindo da screen matriculas
      await test.tap(find.byKey(Key("back_button_appbar")));
      await test.pumpAndSettle();

      //verificando a home
      expect(find.byType(Header), findsOneWidget);
      expect(listScreensInHome, findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(monitoriasMarcadasView, findsOneWidget);
      expect(monitoriaMarcada, findsWidgets);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      await test.drag(listScreensInHome, Offset(1000, 0));
      await test.pumpAndSettle();
      expect(buscarAlunosScreen, findsOneWidget);
      expect(matriculasScreen, findsOneWidget);
      expect(monitoriasScreen, findsOneWidget);

      await test.drag(listScreensInHome, Offset(-1000, 0));
      await test.pumpAndSettle();

      expect(configScreen, findsOneWidget);
      expect(elevatedButtonAddMonitoria, findsOneWidget);

      await test.tap(monitoriasScreen);
      await test.pumpAndSettle();

      expect(find.byType(MonitoriaDetails), findsWidgets);

      //saindo da screen config
      await test.tap(find.byKey(Key("back_button_appbar")));
      await test.pumpAndSettle();
    });
  });
}
