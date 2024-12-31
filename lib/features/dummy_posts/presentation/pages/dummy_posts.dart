import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyPostsPage extends StatefulWidget {
  const DummyPostsPage({super.key});

  @override
  State<DummyPostsPage> createState() => _DummyPostsPageState();
}

class _DummyPostsPageState extends State<DummyPostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('dummy posts'),
        ),
        body: BlocBuilder<DummyPostsCubit, DummyPostsState>(
          builder: (context, state) {
            return switch (state) {
              DummyPostsLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
              DummyPostsLoadSuccessState() => ListView.builder(
                  itemCount: state.dummyPosts.length,
                  itemBuilder: (context, index) {
                    final DummyPost dummyPost = state.dummyPosts[index];
                    return DummyPostCard(post: dummyPost);
                  },
                ),
              DummyPostsLoadFailureState() => Center(
                  child: Text('loading error ${state.message}'),
                ),
              _ => const SizedBox()
            };
          },
        ));
  }
}
