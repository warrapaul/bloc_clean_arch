import 'package:bloc_clean_arch/core/theme/custom_dialog_theme.dart';
import 'package:flutter/material.dart';

class CustomSuccessDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback? onConfirm;

  const CustomSuccessDialog({
    super.key,
    this.title = 'Error',
    required this.content,
    this.confirmText = 'OK',
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          CustomDialogTheme.successIcon,
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
