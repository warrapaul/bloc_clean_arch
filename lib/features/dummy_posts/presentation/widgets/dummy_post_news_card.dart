import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:flutter/material.dart';

class DummyPostNewsCard extends StatelessWidget {
  final DummyPost post;

  const DummyPostNewsCard({
    super.key, required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              post.body,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up, color: Colors.blue),
                      onPressed: () {},
                    ),
                    Text(
                      post.reactions.likes.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.thumb_down, color: Colors.red),
                      onPressed: () {},
                    ),
                    Text(
                      post.reactions.dislikes.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      post.views.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
