import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/bloc/dummy_posts_search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdBlocSearchDelegate extends SearchDelegate<DummyPost?> {
  final DummyPostsSearchBloc searchBloc;

  AdBlocSearchDelegate(this.searchBloc);

  final List<String> searchHistory = [
    "Flutter Bloc",
    "Clean Architecture",
    "State Management",
    "Dart Streams",
    "UI Components"
  ];

  final List<String> popularSearches = [
    "Top Dart Packages",
    "Best Flutter Widgets",
    "love wasn't",
    "NestJS with Flutter",
    "Advanced Bloc Patterns"
  ];

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
    return _buildResultsList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return _buildSearchHistoryAndPopularSearches(context);
    }

    searchBloc.add(DummyPostsSearchQueryChanged(query: query));
    return _buildSuggestionsList();
  }

  /// **Results UI (Full post details)**
  Widget _buildResultsList() {
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
          DummyPostsSearchLoadSuccess(
            dummyPosts: final List<DummyPost> dummyPosts
          ) =>
            dummyPosts.isEmpty
                ? const Center(child: Text('No results found'))
                : ListView.builder(
                    itemCount: dummyPosts.length,
                    itemBuilder: (context, index) {
                      final post = dummyPosts[index];
                      return ListTile(
                        title: Text(post.title,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        subtitle: Text(post.body,
                            maxLines: 3, overflow: TextOverflow.ellipsis),
                        onTap: () => close(context, post),
                      );
                    },
                  ),
          DummyPostsSearchLoadFailure(message: final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
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

  /// **Suggestions UI (Only Titles)**
  Widget _buildSuggestionsList() {
    return BlocBuilder<DummyPostsSearchBloc, DummyPostsSearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        return switch (state) {
          DummyPostsSearchInitial() =>
            const Center(child: Text('Start typing to search...')),
          DummyPostsSearchLoading() =>
            const Center(child: CircularProgressIndicator()),
          DummyPostsSearchLoadSuccess(
            dummyPosts: final List<DummyPost> dummyPosts
          ) =>
            dummyPosts.isEmpty
                ? const Center(child: Text('No suggestions found'))
                : ListView.builder(
                    itemCount: dummyPosts.length,
                    itemBuilder: (context, index) {
                      final post = dummyPosts[index];
                      return ListTile(
                        title: Text(post.title,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        onTap: () {
                          query = post.title;
                          showResults(context);
                        },
                      );
                    },
                  ),
          DummyPostsSearchLoadFailure(message: final message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
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

  /// **Search History & Popular Searches UI**
  Widget _buildSearchHistoryAndPopularSearches(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'History Search',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          _buildChipList(context, searchHistory),
          const Divider(),
          const Text(
            'Popular Searches',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: popularSearches.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(popularSearches[index]),
                  onTap: () {
                    query = popularSearches[index];
                    showResults(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildChipList(BuildContext context, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Wrap(
        spacing: 8.0, // Horizontal spacing between chips
        runSpacing: 8.0, // Vertical spacing between lines of chips
        children: items.map((text) {
          return ActionChip(
            label: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14.0, 
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300), 
              borderRadius: BorderRadius.circular(20.0), 
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0), 
            onPressed: () {
              query = text;
              showResults(context);
            },
          );
        }).toList(),
      ),
    );
  }
}

