import 'package:flutter/material.dart';

class AppImagesPage extends StatelessWidget {
  const AppImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // =============================== AVATARS ============================
              const Text('Avatar'),
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                radius: 30,
              ),
              // =============================== BANNER ============================
              const SizedBox(height: 20),
              const Text('Banner'),
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  'https://images.unsplash.com/photo-1485113771930-4e8b61c60d64?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.cover, // Makes image cover the container
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error);
                  },
                ),
              ),
              // =============================== THUMBNAIL ============================
              const SizedBox(height: 20),
              const Text('Thumbnail'),

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1485113771930-4e8b61c60d64?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
