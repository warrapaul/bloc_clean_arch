import 'package:bloc_clean_arch/features/reusable_widgets/widgets/appbar/app_appbar.dart';
import 'package:bloc_clean_arch/features/reusable_widgets/widgets/images/app_images.dart';
import 'package:flutter/material.dart';

class AppWidgetsPage extends StatelessWidget {
  const AppWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AppImagesPage()));
                },
                child: Text('Images'))
          ],
        ),
      )),
    );
  }
}
