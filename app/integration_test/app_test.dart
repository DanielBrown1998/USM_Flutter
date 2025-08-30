import "package:app/screen/home/components/drawer.dart";
import "package:app/screen/widgets/gen/header.dart";
// import "package:app/widgets/body.dart" as custom_body;
// import "package:app/widgets/monitoria_card.dart";
// import "package:app/widgets/monitoria_details.dart";
import "package:app/main.dart";
import "package:app/domain/models/disciplinas.dart";
import "package:app/domain/models/matricula.dart";
import "package:app/domain/models/monitoria.dart";

import "package:app/controllers/disciplinas_controllers.dart";
import "package:app/controllers/matricula_controllers.dart";
import "package:app/controllers/monitoria_controllers.dart";
import "package:app/controllers/user_controllers.dart";
import "package:app/core/services/disciplina_service.dart";
import "package:app/core/services/matricula_service.dart";
import "package:app/core/services/monitorias_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
// import "package:date_field/date_field.dart";
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
// import "package:lottie/lottie.dart";
import "package:provider/provider.dart";
import "package:app/core/services/firebase_service.dart" as firebase;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Fluxo de Autenticação", () {
    late FirebaseFirestore firestore;

    // Roda uma vez antes de todos os testes no grupo
    setUpAll(() async {
      Provider.debugCheckInvalidValueType = null;
      firestore = await firebase.FirebaseService.initializeFirebase();
    });

    tearDownAll(() {
      debugDefaultTargetPlatformOverride = null;
    });

    // Função auxiliar para inflar o widget do app com os providers
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          FutureProvider<List<Matricula>>.value(
            value: MatriculaService.getAllMatriculas(firestore),
            initialData: const [],
          ),
          FutureProvider<List<Disciplina>>.value(
            value: DisciplinaService.getDisciplinas(firestore: firestore),
            initialData: const [],
          ),
          FutureProvider<List<Monitoria>>.value(
            value: MonitoriasService.getAllMonitorias(firestore),
            initialData: const [],
          ),
          ProxyProvider<List<Matricula>, MatriculaController>(
            update: (context, matriculas, previous) {
              previous ??= MatriculaController(firestore: firestore);
              previous.initializeMatriculas(matriculas);
              return previous;
            },
          ),
          ChangeNotifierProvider<UserController>(
              create: (_) => UserController(firestore: firestore)),
          ChangeNotifierProvider<MonitoriaController>(
              create: (_) => MonitoriaController(firestore: firestore)),
          ChangeNotifierProvider(
              create: (_) => DisciplinasController(firestore: firestore)),
        ],
        child: const USMApp(
          title: "MON. UERJ-ZO Test",
        ),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets("testando o fluxo de login e logout", (test) async {
      const String email = "teste@teste.com";
      const String password = "password123";

      await pumpApp(test);

      // 1. Tela Inicial: Inserir matrícula para ir para a tela de login
      expect(find.text("USM"), findsOneWidget);
      await test.enterText(find.byType(TextFormField), "000000000000");
      await test.tap(find.text("entrar"));
      await test.pumpAndSettle();

      // 2. Tela de Autenticação: Realizar o login
      expect(find.text("Login"), findsOneWidget); // Título do AppBar
      expect(find.text("Realize seu Login"), findsOneWidget);

      final emailField = find.widgetWithText(TextFormField, 'E-mail');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);

      await test.enterText(emailField, email);
      await test.enterText(passwordField, password);
      await test.pumpAndSettle();

      await test.tap(find.widgetWithText(TextButton, "Entrar"));
      await test.pumpAndSettle(const Duration(seconds: 5)); // Espera pelo login
      await test.pumpAndSettle();

      // 3. Tela Home: Verificar se o login foi bem-sucedido
      expect(find.byType(Header), findsOneWidget);
      expect(find.byKey(const Key("home_screen_list")), findsOneWidget);

      // 4. Logout: Abrir o drawer e sair
      await test.tap(find.byIcon(Icons.menu));
      await test.pumpAndSettle();

      final logoutTile = find.widgetWithText(ListTileWidget, 'Sair');
      expect(logoutTile, findsOneWidget);
      await test.tap(logoutTile);
      await test.pumpAndSettle(const Duration(seconds: 2));

      // 5. Tela Inicial: Verificar se o logout retornou à tela inicial
      expect(find.text("USM"), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets("testando login com credenciais inválidas", (test) async {
      await pumpApp(test);

      // 1. Tela Inicial: Inserir matrícula para ir para a tela de login
      expect(find.text("USM"), findsOneWidget);
      await test.enterText(find.byType(TextFormField), "000000000000");
      await test.tap(find.text("entrar"));
      await test.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byKey(const Key("matricula_not_found")), findsNothing);

      // 2. Insere credenciais inválidas
      await test.enterText(
          find.widgetWithText(TextFormField, 'E-mail'), "test@exemplo.com");
      await test.enterText(
          find.widgetWithText(TextFormField, 'Password'), "senhaincorreta");
      await test.pumpAndSettle();

      await test.tap(find.widgetWithText(TextButton, "Entrar"));
      await test.pumpAndSettle();

      // 3. Verifica se a mensagem de erro é exibida
      expect(find.byKey(const Key("invalid_credentials")), findsOneWidget);

      // 4. Verifica se permanece na tela de login
      expect(find.text("Login"), findsOneWidget);
      expect(find.byType(Header), findsNothing);
    });
  });
}
