import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyPostDetailsPage extends StatefulWidget {
  final int postId;
  const DummyPostDetailsPage({super.key, required this.postId});

  @override
  State<DummyPostDetailsPage> createState() => _DummyPostDetailsPageState();
}

class _DummyPostDetailsPageState extends State<DummyPostDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<DummyPostsCubit>().getDummyPostById(widget.postId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: BlocBuilder<DummyPostsCubit, DummyPostsState>(
        builder: (context, state) {
          return switch (state) {
            DummyPostsLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            DummyPostDetailsLoadSuccessState() => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.dummyPost.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(state.dummyPost.body),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: state.dummyPost.tags
                          .map((tag) => Chip(
                                label: Text(tag),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            DummyPostsLoadFailureState() => Center(
                child: Text('Error loading post: ${state.message}'),
              ),
            _ => const SizedBox()
          };
        },
      ),
    );
  }
}
