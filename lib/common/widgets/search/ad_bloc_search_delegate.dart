import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
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

//   Widget _buildChipList(BuildContext context, List<String> items) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Wrap(
//         spacing: 8.0,
//         children: items.map((text) {
//           return ActionChip(
//             label: Text(text),
//             onPressed: () {
//               query = text;
//               showResults(context);
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }

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
              style: TextStyle(
                color: Colors.black87, // Text color
                fontSize: 14.0, // Text size
              ),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300), // Border color
              borderRadius: BorderRadius.circular(20.0), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 8.0), // Padding inside the chip
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


// class AdBlocSearchDelegate extends SearchDelegate {
//   final DummyPostsSearchBloc searchBloc;
//   AdBlocSearchDelegate(this.searchBloc);


//   // Hardcoded placeholders for search history and popular searches
//   final List<String> searchHistory = [
//     "Flutter Bloc",
//     "Clean Architecture",
//     "State Management",
//     "Dart Streams",
//     "UI Components"
//   ];

//   final List<String> popularSearches = [
//     "Top Dart Packages",
//     "Best Flutter Widgets",
//     "Bloc vs Provider",
//     "NestJS with Flutter",
//     "Advanced Bloc Patterns"
//   ];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           if (query.isEmpty) {
//             close(context, null);
//           } else {
//             query = '';
//             searchBloc.add(DummyPostsClearSearch());
//           }
//         },
//         icon: const Icon(Icons.close),
//       )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     searchBloc.add(DummyPostsSearchQueryChanged(query: query));
//     return _buildDummySearchResults();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     if (query.trim().isEmpty) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Search History',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchHistory.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(searchHistory[index]),
//                   onTap: () {
//                     query = searchHistory[index];
//                     showResults(context);
//                   },
//                 );
//               },
//             ),
//           ),
//           const Divider(),
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Popular Searches',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: popularSearches.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(popularSearches[index]),
//                   onTap: () {
//                     query = popularSearches[index];
//                     showResults(context);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     }
//     searchBloc.add(DummyPostsSearchQueryChanged(query: query));
//     return _buildDummySearchSuggestions();
//   }
// 
//   Widget _buildDummySearchResults() {
//     return BlocBuilder<DummyPostsSearchBloc, DummyPostsSearchState>(
//       bloc: searchBloc,
//       builder: (context, state) {
//         return switch (state) {
//           DummyPostsSearchInitial() => const Center(
//               child: Text('Start typing to search...'),
//             ),
//           DummyPostsSearchLoading() => const Center(
//               child: CircularProgressIndicator(),
//             ),
//           DummyPostsSearchLoadSuccess(
//             dummyPosts: final List<DummyPost> dummyPosts
//           ) =>
//             dummyPosts.isEmpty
//                 ? const Center(child: Text('No results found'))
//                 : _buildResultList(dummyPosts),
//           DummyPostsSearchLoadFailure(message: final message) => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error: $message',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//             ),
//         };
//       },
//     );
//   }

//   Widget _buildResultList(List<DummyPost> dummyPosts) {
//     return ListView.builder(
//       itemCount: dummyPosts.length,
//       itemBuilder: (context, index) {
//         final DummyPost post = dummyPosts[index];
//         return ListTile(
//           title: Text(
//             post.title,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           subtitle: Text(
//             post.body,
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//           ),
//           onTap: () => close(context, post),
//         );
//       },
//     );
//   }

//   Widget _buildDummySearchSuggestions() {
//     return BlocBuilder<DummyPostsSearchBloc, DummyPostsSearchState>(
//       bloc: searchBloc,
//       builder: (context, state) {
//         return switch (state) {
//           DummyPostsSearchInitial() => const Center(
//               child: Text('Start typing to search...'),
//             ),
//           DummyPostsSearchLoading() => const Center(
//               child: CircularProgressIndicator(),
//             ),
//           DummyPostsSearchLoadSuccess(
//             dummyPosts: final List<DummyPost> dummyPosts
//           ) =>
//             dummyPosts.isEmpty
//                 ? const Center(
//                     child: Text('No suggestions found'),
//                   )
//                 : _buildSuggestionList(dummyPosts),
//           DummyPostsSearchLoadFailure(message: final message) => Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: 60,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Error: $message',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//             ),
//         };
//       },
//     );
//   }

//   Widget _buildSuggestionList(List<DummyPost> dummyPosts) {
//     return ListView.builder(
//       itemCount: dummyPosts.length,
//       itemBuilder: (context, index) {
//         final DummyPost post = dummyPosts[index];
//         return ListTile(
//           title: Text(
//             post.title,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           onTap: () {
//             query = post.title; // Update the query with the selected suggestion
//             showResults(context); // Show results for the selected suggestion
//           },
//         );
//       },
//     );
//   }
// }
