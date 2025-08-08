import 'package:app/domain/models/user.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserCard extends StatelessWidget {
  final String? photoURL;
  final User user;
  final auth.User? currentUser;
  const UserCard(
      {super.key, required this.user, this.currentUser, this.photoURL});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key(user.uid),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      photoURL != null
                          ? CircleAvatar(
                              radius: 60,
                              child: Image.network(photoURL!),
                            )
                          : CircleAvatar(radius: 60, child: Text("no-image")),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 5,
                        children: [
                          Text(
                            textAlign: TextAlign.right,
                            "${user.firstName} ${user.lastName}",
                            style: theme.textTheme.displayLarge,
                          ),
                          Text(
                            user.userName,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.displaySmall,
                          ),
                          Text(
                            user.phone,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.displaySmall,
                          ),
                          Text(
                            user.campus,
                            textAlign: TextAlign.right,
                            style: theme.textTheme.displaySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (currentUser != null && user.uid == currentUser!.uid)
                      ? Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.start,
                          spacing: 5,
                          children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "E-MAIL",
                                      style: theme.textTheme.displayMedium,
                                    ),
                                    Text(
                                      user.email,
                                      textAlign: TextAlign.right,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ]),
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Alterar imagem perfil",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Alterar senha",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Aualizar dados",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              ),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(
                                "E-MAIL",
                                style: theme.textTheme.displayMedium,
                              ),
                              Text(
                                user.email,
                                textAlign: TextAlign.right,
                                softWrap: true,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.displaySmall,
                              ),
                            ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 5,
              children: [
                (currentUser != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      )
                    : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Usuario ativo?",
                        style: theme.textTheme.displaySmall),
                    Icon(
                      Icons.circle,
                      color: (!user.isActive) ? Colors.red : Colors.green,
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
                user.disciplinas.length,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: theme.colorScheme.onPrimaryContainer),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Text(
                        user.disciplinas[index].nome,
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
    );
  }
}
