import "package:app/screen/home/components/drawer.dart";
import "package:app/screen/widgets/gen/header.dart";
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
import "package:flutter/material.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:lottie/lottie.dart";
import "package:provider/provider.dart";
import "package:app/core/services/firebase_service.dart" as firebase;

void main() {
  group("Fluxo de Autenticação", () {
    late FirebaseFirestore firestore;
    late String email;
    late String password;
    late String matricula;

    // Roda uma vez antes de todos os testes no grupo
    setUpAll(() async {
      Provider.debugCheckInvalidValueType = null;
      firestore = await firebase.FirebaseService.initializeFirebase();
      email = "teste@teste.com";
      password = "password123";
      matricula = "000000000000";
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
          //substituindo o ChangeNotifierProvider deixando o listen = false
          ProxyProvider<List<Matricula>, MatriculaController>(
            update: (_, matriculas, previousController) {
              final controller = previousController ??
                  MatriculaController(firestore: firestore);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.initializeMatriculas(matriculas);
              });
              return controller;
            },
          ),
          ProxyProvider<List<Disciplina>, DisciplinasController>(
            update: (_, disciplinas, previousController) {
              final controller = previousController ??
                  DisciplinasController(firestore: firestore);
              // Defer the update to after the build phase to avoid "setState during build" error.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.initializeDisciplinas(disciplinas);
              });
              return controller;
            },
          ),
          ChangeNotifierProvider<UserController>(
              create: (_) => UserController(firestore: firestore)),
          ChangeNotifierProvider<MonitoriaController>(
              create: (_) => MonitoriaController(firestore: firestore)),
        ],
        child: const USMApp(
          title: "MON. UERJ-ZO Test",
        ),
      ));
      await tester.pumpAndSettle();
    }

    testWidgets("testando o fluxo de login e logout", (test) async {
      await pumpApp(test);

      // 1. Tela Inicial: Inserir matrícula para ir para a tela de login
      expect(find.text("USM"), findsOneWidget);
      await test.enterText(find.byType(TextFormField), matricula);
      // É uma boa prática esconder o teclado após inserir texto para evitar
      // que ele cubra outros widgets na tela e cause problemas de foco.
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await test.pumpAndSettle();
      await test.tap(find.text("entrar"));
      // First pumpAndSettle for the navigation animation to complete.
      await test.pumpAndSettle(); // Wait for navigation to login screen
      // 2. Tela de Autenticação: Realizar o login
      expect(find.text("Realize seu Login"), findsOneWidget);
      expect(find.text(matricula), findsOneWidget);
      expect(find.byKey(Key("wellcome_text")), findsOneWidget);

      final emailField = find.widgetWithText(TextFormField, 'E-mail');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final forgetPassword = find.text("Esqueci minha senha");

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(forgetPassword, findsOneWidget);

      await test.enterText(emailField, email);
      await test.enterText(passwordField, password);
      // Esconde o teclado antes de tocar no botão de login para garantir
      // que ele não esteja obstruído.
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await test.pumpAndSettle();

      // Toca no botão de entrar.
      await test.tap(find.widgetWithText(TextButton, "Entrar"));
      await test.pumpAndSettle(Duration(seconds: 2));
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
    });

    testWidgets("testando login com credenciais inválidas", (test) async {
      await pumpApp(test);

      // 1. Tela Inicial: Inserir matrícula para ir para a tela de login
      expect(find.text("USM"), findsOneWidget);
      await test.enterText(find.byType(TextFormField), matricula);
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await test.pumpAndSettle();
      await test.tap(find.text("entrar"));
      await test.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byKey(const Key("matricula_not_found")), findsNothing);

      final emailField = find.widgetWithText(TextFormField, 'E-mail');
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      final forgetPassword = find.text("Esqueci minha senha");

      // 2. Insere credenciais inválidas
      await test.enterText(emailField, "test@exemplo.com");
      await test.enterText(passwordField, "senhaincorreta");
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await test.pumpAndSettle();

      await test.tap(find.widgetWithText(TextButton, "Entrar"));
      await test.pumpAndSettle();

      final tryAgainButton =
          find.widgetWithText(TextButton, "Tentar novamente");
      // 3. Verifica se a mensagem de erro é exibida
      expect(find.text("Login ou senha invalidos"), findsOneWidget);
      expect(tryAgainButton, findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      // Espera a mensagem de erro desaparecer.
      await test.pumpAndSettle();

      await test.tap(tryAgainButton);
      await test.pump();
      await test.pumpAndSettle();

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(forgetPassword, findsOneWidget);
    });
  });
}
