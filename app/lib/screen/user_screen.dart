import 'package:app/controllers/user_controllers.dart';
import 'package:app/models/disciplinas.dart';
import 'package:app/services/auth_service.dart';
import 'package:app/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  bool updateUser = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ThemeUSM.shadowColor,
      body: SingleChildScrollView(
        child: Consumer<UserController>(builder: (context, user, widget) {
          auth.User? currentUser = AuthService().getUser;
          email.text = user.user!.email;
          phone.text = user.user!.phone;
          firstName.text = user.user!.firstName;
          lastName.text = user.user!.lastName;
          final theme = Theme.of(context);
          return !updateUser
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 48, bottom: 16),
                  child: Column(
                    spacing: 30,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Meus Dados",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Card(
                        elevation: 20,
                        color: ThemeUSM.blackColor,
                        shadowColor: theme.colorScheme.onPrimaryContainer,
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        currentUser!.photoURL != null
                                            ? CircleAvatar(
                                                radius: 60,
                                                child: Image.network(
                                                    currentUser.photoURL!),
                                              )
                                            : CircleAvatar(
                                                radius: 60,
                                                child: Text("no-image")),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.right,
                                              "${user.user!.firstName} ${user.user!.lastName}",
                                              style:
                                                  theme.textTheme.displayLarge,
                                            ),
                                            Text(
                                              user.user!.userName,
                                              textAlign: TextAlign.right,
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                            Text(
                                              user.user!.phone,
                                              textAlign: TextAlign.right,
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                            Text(
                                              user.user!.email,
                                              textAlign: TextAlign.right,
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                            Text(
                                              user.user!.campus,
                                              textAlign: TextAlign.right,
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Wrap(
                                        direction: Axis.horizontal,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        runAlignment: WrapAlignment.start,
                                        spacing: 5,
                                        children: [
                                          Material(
                                            color: theme
                                                .colorScheme.onPrimaryContainer,
                                            shape: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: theme.primaryColor,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: InkWell(
                                              splashColor: theme.splashColor,
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Alterar imagem perfil",
                                                  style: theme
                                                      .textTheme.displaySmall,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: theme
                                                .colorScheme.onPrimaryContainer,
                                            shape: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: theme.primaryColor,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: InkWell(
                                              splashColor: theme.splashColor,
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Alterar senha",
                                                  style: theme
                                                      .textTheme.displaySmall,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: theme
                                                .colorScheme.onPrimaryContainer,
                                            shape: Border.all(
                                              width: 1,
                                              style: BorderStyle.solid,
                                              color: theme.primaryColor,
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: InkWell(
                                              splashColor: theme.splashColor,
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Aualizar dados",
                                                  style: theme
                                                      .textTheme.displaySmall,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 5,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'E-mail verificado: ',
                                        style: theme.textTheme.displaySmall,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: currentUser!.emailVerified
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Usuario ativo?",
                                          style: theme.textTheme.displaySmall),
                                      Icon(
                                        Icons.circle,
                                        color: (!user.user!.isActive)
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Disciplinas disponiveis;",
                                style: theme.textTheme.displaySmall,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Divider(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 5,
                                alignment: WrapAlignment.spaceEvenly,
                                children: List<Widget>.generate(
                                  user.user!.disciplinas.length,
                                  (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: theme.colorScheme
                                                  .onPrimaryContainer),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 2.0),
                                        child: Text(
                                          user.user!.disciplinas[index].nome,
                                          style: theme.textTheme.displaySmall,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Lottie.asset("lib/assets/loties/laptop.json"),
                      Text(
                        "Acoes a realizar:",
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyMedium,
                      ),
                      (!currentUser.emailVerified)
                          ? Material(
                              shape: Border.all(
                                width: 2,
                                style: BorderStyle.solid,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              elevation: 10,
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                splashColor: theme.splashColor,
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "verificar email",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      (currentUser.phoneNumber == null)
                          ? Material(
                              shape: Border.all(
                                width: 2,
                                style: BorderStyle.solid,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              elevation: 10,
                              clipBehavior: Clip.antiAlias,
                              child: InkWell(
                                splashColor: theme.splashColor,
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "validar celular",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 48, bottom: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Atualizar Dados",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          controller: firstName,
                          decoration: const InputDecoration(
                            labelText: 'nome: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu nome.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          controller: lastName,
                          decoration: const InputDecoration(
                            labelText: 'sobre-nome: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu sobre-nome.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          initialValue: user.user!.userName,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'matricula: ',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          controller: email,
                          decoration: const InputDecoration(
                            labelText: 'e-mail: ',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu email.';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Por favor, insira um email válido.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'phone: ',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu telefone.';
                            }
                            if (value.length != 11) {
                              return "11 digitos apenas";
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Por favor, insira um telefone válido (apenas números).';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: theme.textTheme.bodyMedium,
                          initialValue: user.user!.campus,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'campus',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
