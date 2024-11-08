import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';

class Test2 extends StatelessWidget {
  final String id;

  const Test2({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This is the detail page for item $id'),
            ElevatedButton(
              onPressed: () {
                AppRouter.router.go('/test1');
              },
              child: const Text('Test 1'),
            ),
          ],
        ),
      ),
    );
  }
}
