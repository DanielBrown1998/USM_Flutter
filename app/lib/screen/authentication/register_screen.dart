import 'package:app/domain/models/user.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/screen/widgets/logo_laptop.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:app/controllers/user_controllers.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    password2.dispose();
    super.dispose();
  }

  Future<bool> register(BuildContext context, UserController controller,
      {required String email,
      required String firstName,
      required String lastName,
      required String password,
      required String phone,
      required Matricula matricula,
      isStaff = false,
      isSuperUser = false,
      isActive = true}) async {
    User? user = await controller.register(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phone: phone,
        matricula: matricula);

    return (user != null) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, controller, _) {
      Matricula matriculaData = controller.matricula!;

      return Scaffold(
          backgroundColor: ThemeUSM.blackColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: LogoLaptop(),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        initialValue: matriculaData.matricula,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Matrícula',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: firstName,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu nome.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: lastName,
                        decoration: const InputDecoration(
                          labelText: 'Sobrenome',
                          hintStyle: TextStyle(color: Colors.purple),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu sobrenome.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
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
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: phone,
                        decoration: const InputDecoration(
                          labelText: 'telefone',
                          icon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
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
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira uma senha.';
                          }
                          if (value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        controller: password2,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Senha',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme sua senha.';
                          }
                          if (value != password.text) {
                            return 'As senhas não coincidem.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: ThemeUSM.dividerDrawerColor),
                        initialValue: matriculaData.campus,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Campus',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeUSM.dividerDrawerColor,
                            foregroundColor: ThemeUSM.whiteColor),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isRegister = false;

                            User? newUser =
                                await controller.getUserByEmailForLogin(email: email.text);
                            if (newUser != null) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Usuario com email JA Registrado')),
                              );
                            } else {
                              if (!context.mounted) return;
                              isRegister = await register(
                                  context, controller,
                                  email: email.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  password: password.text,
                                  phone: phone.text,
                                  matricula: matriculaData);
                            }
                            if (isRegister) {
                              if (!context.mounted) return;
                              Navigator.popAndPushNamed(context, Routes.home);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Usuario Registrado com sucesso!')),
                              );
                            } else {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Registro de usuario falhou!')),
                              );
                            }
                          }
                        },
                        child: const Text('Cadastrar'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
