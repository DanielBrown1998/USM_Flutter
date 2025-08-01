import 'package:app/models/user.dart';
import 'package:app/widgets/user_card.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatefulWidget {
  final User user;
  const StudentCard({super.key, required this.user});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool showUserCard = false;
  Widget? _widget;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget studentCard = Card(
      key: Key("student_card"),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimaryFixed,
          width: 2,
        ),
      ),
      shadowColor: theme.colorScheme.onPrimaryFixed,
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${widget.user.firstName} ${widget.user.lastName}",
                    style: theme.textTheme.bodyMedium,
                  ),
                  Text(
                    widget.user.userName,
                    style: theme.textTheme.bodyLarge,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.user.phone, style: theme.textTheme.bodyMedium),
                  Text(
                    widget.user.lastLogin.toString().split(' ')[0],
                    style: theme.textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    return Material(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: InkWell(
          onTap: () {
            setState(() {
              showUserCard = !showUserCard;
              _widget =
                  (showUserCard) ? UserCard(user: widget.user) : studentCard;
            });
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return SizeTransition(
                axis: Axis.vertical,
                // alignment: Alignment.topCenter,
                sizeFactor: animation,
                child: child,
              );
            },
            reverseDuration: Duration(milliseconds: 500),
            duration: Duration(milliseconds: 500),
            child: (_widget != null) ? _widget : studentCard,
          ),
        ));
  }
}
