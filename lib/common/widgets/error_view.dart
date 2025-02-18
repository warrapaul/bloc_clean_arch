import 'package:flutter/material.dart';

class ErrorViewWidget extends StatelessWidget {
  final String message;
  // final VoidCallback onRetry;

  const ErrorViewWidget({
    required this.message,
    // required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 16),
          // ElevatedButton(
          //   onPressed: onRetry,
          //   child: const Text('Retry'),
          // ),
        ],
      ),
    );
  }
}
