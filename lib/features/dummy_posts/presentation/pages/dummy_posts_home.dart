import 'package:bloc_clean_arch/common/widgets/error_view.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/search/ad_bloc_search_delegate.dart';
import 'package:bloc_clean_arch/common/widgets/tuts/search/simple_bloc_search_delegate.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/bloc/dummy_posts_search_bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_post_tags/dummy_post_tags_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_post_card.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_post_tags_scroll_view.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_posts_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyPostsHomePage extends StatefulWidget {
  const DummyPostsHomePage({super.key});

  @override
  State<DummyPostsHomePage> createState() => _DummyPostsHomePageState();
}

class _DummyPostsHomePageState extends State<DummyPostsHomePage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Posts'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  final result = await showSearch(
                    context: context,
                    // delegate: DummyPostsSearchDelegate(
                    //   context.read<DummyPostsSearchBloc>(),
                    // ),
                    delegate: AdBlocSearchDelegate(
                      context.read<DummyPostsSearchBloc>(),
                    ),
                  );

                  // Handle the selected post
                  if (result != null) {
                    print(result.title);
                    debugPrint(
                        'Selected Post: ${result.toString()}'); // Print the selected post
                    // You can also navigate to a details page or show a dialog here
                  }
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<DummyPostTagsCubit, DummyPostTagsState>(
              builder: (context, state) {
            return switch (state) {
              DummyPostTagsLoadingState() => const CircularProgressIndicator(),
              DummyPostTagsLoadSuccessState() => DummyPostTagsScrollView(
                  tags: state.tags,
                  selectedIndex: _selectedIndex,
                  onTagSelected: (tag) {
                    setState(() => _selectedIndex = state.tags.indexOf(tag));
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    context.read<DummyPostsCubit>().getDummyPostsByTag(
                          FilterDummyPostsReqParams(tag: tag.name),
                        );
                  },
                ),
              DummyPostTagsLoadFailureState() => Text(state.message),
              _ => const SizedBox()
            };
          }),
          Expanded(
            child: BlocBuilder<DummyPostTagsCubit, DummyPostTagsState>(
              builder: (context, tagsState) {
                if (tagsState is! DummyPostTagsLoadSuccessState) {
                  return const SizedBox();
                }

                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _selectedIndex = index);
                    final tag = tagsState.tags[index];
                    context.read<DummyPostsCubit>().getDummyPostsByTag(
                          FilterDummyPostsReqParams(tag: tag.name),
                        );
                  },
                  itemCount: tagsState.tags.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<DummyPostsCubit, DummyPostsState>(
                      builder: (context, state) => switch (state) {
                        DummyPostsLoadingState() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        DummyPostsLoadSuccessState() => ListView.builder(
                            itemCount: state.dummyPosts.length,
                            itemBuilder: (context, index) =>
                                DummyPostCard(post: state.dummyPosts[index]),
                          ),
                        DummyPostsLoadFailureState() => ErrorViewWidget(
                            message: state.error.message,
                          ),
                        _ => const SizedBox()
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
