import 'package:bloc_clean_arch/common/widgets/error_view.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_post_card.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyPostsPage extends StatefulWidget {
  const DummyPostsPage({super.key});

  @override
  State<DummyPostsPage> createState() => _DummyPostsPageState();
}

class _DummyPostsPageState extends State<DummyPostsPage> {
  int _currentPage = 1;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
       _loadInitialPosts();

  }

  Future<void> _loadInitialPosts() async {
    setState(() {
      _currentPage = 1;
    });

    await context.read<DummyPostsCubit>().getDummyPosts(
          FilterDummyPostsReqParams(page: _currentPage, pageSize: _pageSize),
        );
  }
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
                    child: ErrorViewWidget(
                  message: state.error.message,
                )),
              _ => const SizedBox()
            };
          },
        ));
  }
}
