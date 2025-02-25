import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/bloc/dummy_posts_search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SimpleBlocSearchDelegate extends SearchDelegate{
  final DummyPostsSearchBloc searchBloc;

  SimpleBlocSearchDelegate(this.searchBloc);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            searchBloc.add(DummyPostsClearSearch());
          }
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(DummyPostsSearchQueryChanged(query: query));
    return _buildDummySearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Center(child: Text('Start typing to search...'));
    }
    searchBloc.add(DummyPostsSearchQueryChanged(query: query));
    return _buildDummySearchResults();
  }

  Widget _buildDummySearchResults() {
    return BlocBuilder<DummyPostsSearchBloc, DummyPostsSearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        return switch (state) {
          DummyPostsSearchInitial() => const Center(
              child: Text('Start typing to search...'),
            ),
          DummyPostsSearchLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          DummyPostsSearchLoadSuccess(dummyPosts: final List<DummyPost> dummyPosts) =>
            dummyPosts.isEmpty
                ? const Center(child: Text('No results found'))
                : _buildPostList(dummyPosts),
          DummyPostsSearchLoadFailure(message: final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: $message',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }

  Widget _buildPostList(List<DummyPost> dummyPosts) {
    return ListView.builder(
      itemCount: dummyPosts.length,
      itemBuilder: (context, index) {
        final DummyPost post = dummyPosts[index];
        return ListTile(
          title: Text(
            post.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            post.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => close(context, post),
        );
      },
    );
  }
}