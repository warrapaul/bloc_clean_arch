import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatelessWidget {
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  const NotificationsPage({super.key, this.title, this.body, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification"),
      leading: IconButton(onPressed: (){
                    context.pushNamed(AppRoutePaths.home);

      }, icon: const Icon(Icons.arrow_back)),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text("Title: $title", style: const TextStyle(fontSize: 20)),
              if (body != null)
                Text("Body: $body", style: const TextStyle(fontSize: 16)),
              if (data != null) ...[
                const SizedBox(height: 10),
                const Text("Data:", style: TextStyle(fontSize: 18)),
                Text(data.toString(), style: const TextStyle(fontSize: 14)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
