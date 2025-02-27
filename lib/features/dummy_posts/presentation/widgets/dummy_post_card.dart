import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DummyPostCard extends StatelessWidget {
  final DummyPost post;
  const DummyPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: InkWell(
        onTap: () {
          // context.pushNamed('${AppRoutePaths.dummyPostDetail}/${post.id}');
          context.pushNamed(
            AppRoutePaths.dummyPostDetailName,
            pathParameters: {'id': post.id.toString()},
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                post.body,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: (post.tags).map((tag) {
                  return Chip(label: Text(tag));
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Likes: ${post.reactions.likes}'),
                  Text('Views: ${post.views}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
