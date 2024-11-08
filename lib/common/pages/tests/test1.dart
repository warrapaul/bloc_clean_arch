import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // AppRouter2.router.go('/test2/123');
                        // router.go('/test2/123');
                        AppRouter.router.go('/test2/123');

          },
          child: const Text('Test 2'),
        ),
      ),
    );
  }
}
