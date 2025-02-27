import 'package:bloc_clean_arch/core/theme/custom_styles/custom_dialog_theme.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomConfirmationDialog({
    super.key,
    this.title = 'Confirm Action',
    required this.content,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.onConfirm, this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          CustomDialogTheme.confirmationIcon,
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirm?.call();
                  },
                  child: Text(confirmText),
                ),
              ],
            ),

          ],
        ),
        
      ],
    );
  }
}
