import 'package:bloc_clean_arch/common/widgets/tuts/dialogs/widgets/custom_confirmation_dialog.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/dialogs/widgets/custom_error_dialog.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/dialogs/widgets/custom_info_alert.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/dialogs/widgets/custom_success_dialog.dart';
import 'package:flutter/material.dart';

class DialogHome extends StatelessWidget {
  const DialogHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alert dialogs'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => showConfirmationDialog(context),
                  child: const Text('Show Dialog'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => showErrorDialog(context),
                  child: const Text('Error Dialog'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => showSuccessDialog(context),
                  child: const Text('Success Dialog'),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => showConfirmAlert(context),
                  child: const Text('Confirm Alert'),
                ),
              ],
            ),
          ),
        ));
  }

void showConfirmAlert(BuildContext context) async{
  final bool? result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) => ConfirmationDialog(
        title: 'Confirm Action',
        // content: 'Are you sure you want to proceed?',
        onConfirm: () {
          print('User confirmed the action');
        }, message: '', onCancel: () {  },
      ),
    );

    print(result);
}
  void showSuccessDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.3),
        builder: (BuildContext context) => CustomSuccessDialog(
              title: 'Record created Successfully',
              content: 'New record has been created',
              onConfirm: () {
                print('User confirmed the action');
              },
            ));

    print(result);
  }

  void showErrorDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.3),
        builder: (BuildContext context) => CustomErrorDialog(
              title: 'An Error occurred',
              content: 'Info already exists',
              onConfirm: () {
                print('User confirmed the action');
              },
            ));

    print(result);
  }

  void showConfirmationDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) => CustomConfirmationDialog(
        title: 'Confirm Action',
        content: 'Are you sure you want to proceed?',
        onConfirm: () {
          print('User confirmed the action');
        },
      ),
    );

    if (result == true) {
      print('User confirmed');
    } else {
      print('User canceled');
    }
  }
}
