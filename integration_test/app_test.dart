import "package:app/components/drawer.dart";
import "package:app/components/header.dart";
import "package:app/components/body.dart" as custom_body;
import "package:app/components/monitoria_card.dart";
import "package:app/main.dart";
import "package:app/models/days.dart";
import "package:app/models/matricula.dart";
import "package:app/controllers/days_objects.dart";
import "package:app/controllers/matricula_objects.dart";
import "package:app/controllers/monitoria_objects.dart";
import "package:app/controllers/user_objects.dart";
import "package:app/services/days_service.dart";
import "package:app/services/matricula_service.dart";
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
      FirebaseFirestore firestore =
          await firebase.FirebaseService.initializeFirebase();
      List<Matricula> matriculas =
          await MatriculaService.takeMatriculas(firestore);
      List<Days> days = await DaysService.takeDays(firestore);

      await test.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => MatriculaObjects(matriculas: matriculas)),
          ChangeNotifierProvider(create: (_) => UserObjects()),
          ChangeNotifierProvider(create: (_) => DaysObjects(days: days)),
          ChangeNotifierProvider(create: (_) => MonitoriaObjects()),
        ],
        child: const MyApp(
          title: "MON. UERJ-ZO Test",
        ),
      ));
      await test.pumpAndSettle();

      expect(find.text("USM"), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text("entrar"), findsOneWidget);

      await test.enterText(find.byType(TextFormField), "202213313611");
      await test.pumpAndSettle();
      await test.tap(find.text("entrar"));
      await test.pumpAndSettle();

      expect(find.byType(Header), findsOneWidget);
      expect(find.byType(custom_body.ListBody), findsOneWidget);
      expect(find.byType(Card), findsWidgets);
      expect(find.byType(custom_body.MonitoriaView), findsOneWidget);
      expect(find.byType(MonitoriaCard), findsWidgets);
      expect(find.byType(FloatingActionButton), findsOneWidget);

      expect(find.text("buscar alunos"), findsOneWidget);
      expect(find.text("matriculas"), findsOneWidget);
      expect(find.text("monitorias"), findsOneWidget);

      await test.drag(find.byType(custom_body.ListBody), Offset(-1000, 0));
      await test.pumpAndSettle();

      expect(find.text("config"), findsOneWidget);
      expect(find.byKey(Key("add_monitoria")), findsOneWidget);

      await test.tap(find.byKey(Key("add_monitoria")));
      await test.pumpAndSettle(Duration(seconds: 4));

      expect(find.text("Add Monitoria"), findsOneWidget);
      expect(find.byKey(Key("add_monitoria_image")), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(DateTimeFormField), findsOneWidget);
      var iconWidgetRemoveAlertDialog =
          find.byIcon(Icons.highlight_remove_sharp);
      expect(iconWidgetRemoveAlertDialog, findsOneWidget);

      await test.tap(iconWidgetRemoveAlertDialog);
      await test.pumpAndSettle();

      expect(find.text("Add Monitoria"), findsNothing);
      expect(find.byKey(Key("add_monitoria_image")), findsNothing);
      expect(find.byType(TextFormField), findsNothing);
      expect(find.byIcon(Icons.menu), findsWidgets);

      await test.tap(find.byIcon(Icons.menu));
      await test.pumpAndSettle();

      expect(find.byType(DrawerHeader), findsOneWidget);
      expect(find.byType(ListTileWidget), findsNWidgets(6));
      var buttonBack = find.byKey(Key("back_drawer"));
      expect(buttonBack, findsOneWidget);

      await test.tap(buttonBack);
      await test.pumpAndSettle();

      expect(find.byType(DrawerHeader), findsNothing);
    });
  });
}
