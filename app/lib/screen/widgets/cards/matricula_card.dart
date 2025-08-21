import 'package:app/controllers/matricula_controllers.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/domain/models/matricula.dart';
import 'package:flutter/material.dart';

class MatriculaCard extends StatefulWidget {
  final Matricula matricula;
  final MatriculaController matriculaController;
  const MatriculaCard(
      {super.key, required this.matricula, required this.matriculaController});

  @override
  State<MatriculaCard> createState() => _MatriculaCardState();
}

class _MatriculaCardState extends State<MatriculaCard> {
  bool flagShowDataOfMatricula = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final size = MediaQuery.sizeOf(context);
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          // update screen here
        }
      },
      background: Container(
        decoration: BoxDecoration(color: ThemeUSM.purpleUSMColor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 5,
            children: [
              Text(
                "atualizar",
                style: theme.textTheme.displaySmall,
              ),
              Icon(
                Icons.update,
                color: theme.primaryColor,
              ),
            ],
          ),
        )),
      ),
      direction: DismissDirection.endToStart,
      key: Key(widget.matricula.matricula),
      child: Card(
        shadowColor: ThemeUSM.purpleUSMColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ThemeUSM.purpleUSMColor, width: 2)),
        child: InkWell(
          onTap: () {
            setState(() {
              flagShowDataOfMatricula = !flagShowDataOfMatricula;
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.arrow_back_ios,
                    )),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 5,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.matricula.matricula,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Visibility(
                        visible: !flagShowDataOfMatricula,
                        child: Text(
                          "numero de disciplinas: ${widget.matricula.disciplinas.length.toString()}",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Visibility(
                          visible: flagShowDataOfMatricula,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Disciplinas",
                                style: theme.textTheme.bodyLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List<Widget>.generate(
                                  widget.matricula.disciplinas.length,
                                  (index) => Text(
                                    widget.matricula.disciplinas[index].nome,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              Text(
                                "Campus",
                                style: theme.textTheme.bodyLarge,
                              ),
                              Text(
                                widget.matricula.campus,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
