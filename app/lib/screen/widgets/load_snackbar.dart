import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class LoadSnackbar extends StatelessWidget {
  const LoadSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircularProgressIndicator(
      strokeCap: StrokeCap.round,
      constraints: BoxConstraints(
          maxHeight: 30, maxWidth: 30, minHeight: 16, minWidth: 16),
      strokeWidth: 4,
      padding: EdgeInsets.all(8),
      backgroundColor: ThemeUSM.blackColor,
      trackGap: 5,
      color: theme.colorScheme.onPrimaryContainer,
    );
  }
}
