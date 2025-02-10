import 'package:bloc_clean_arch/common/widgets/search/ad_bloc_search_delegate.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/bloc/dummy_posts_search_bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/cubit/dummy_posts/dummy_posts_cubit.dart';
import 'package:bloc_clean_arch/features/dummy_posts/presentation/widgets/dummy_post_news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfiniteScrollHomePage extends StatefulWidget {
  const InfiniteScrollHomePage({super.key});

  @override
  State<InfiniteScrollHomePage> createState() => _InfiniteScrollHomePageState();
}

class _InfiniteScrollHomePageState extends State<InfiniteScrollHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;
  static const int _pageSize = 10;
  bool _hasReachedMax = false;
  List<DummyPost> _allPosts = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialPosts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7 &&
        !_isLoading &&
        !_hasReachedMax) {
      _loadMoreDummyPosts();
    }
  }

  Future<void> _loadInitialPosts() async {
    setState(() {
      _currentPage = 1;
      _hasReachedMax = false;
      _isLoading = true;
    });

    await context.read<DummyPostsCubit>().getDummyPosts(
          FilterDummyPostsReqParams(page: _currentPage, pageSize: _pageSize),
        );
  }

  Future<void> _loadMoreDummyPosts() async {
    if (_isLoading || _hasReachedMax) return;

    setState(() {
      _isLoading = true;
    });

    final nextPage = _currentPage + 1;

    await context.read<DummyPostsCubit>().getDummyPosts(
          FilterDummyPostsReqParams(page: nextPage, pageSize: _pageSize),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Posts Infinite'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: AdBlocSearchDelegate(
                  context.read<DummyPostsSearchBloc>(),
                ),
              );
            },
            icon: const Icon(Icons.search, size: 20),
          )
        ],
      ),
      body: BlocConsumer<DummyPostsCubit, DummyPostsState>(
        listener: (context, state) {
          if (state is DummyPostsLoadSuccessState) {
            setState(() {
              _isLoading = false;

              if (_currentPage == 1) {
                _allPosts = state.dummyPosts;
              } else {
                _allPosts.addAll(state.dummyPosts);
              }

              if (state.dummyPosts.length < _pageSize) {
                _hasReachedMax = true;
              } else {
                _currentPage++;
              }
            });
          } else if (state is DummyPostsLoadFailureState) {
            setState(() {
              _isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is DummyPostsLoadingState && _allPosts.isEmpty) {
            // Only show this when initially loading and no data is available
            return const Center(child: CircularProgressIndicator());
          } else if (_allPosts.isEmpty) {
            return RefreshIndicator(
              onRefresh: _loadInitialPosts,
              child: ListView(
                children: const [Center(child: Text('No posts available'))],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadInitialPosts,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _allPosts.length + (_hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= _allPosts.length) {
                  return _isLoading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox();
                }
                return DummyPostNewsCard(post: _allPosts[index]);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


// class InfiniteScrollHomePage extends StatefulWidget {
//   const InfiniteScrollHomePage({super.key});

//   @override
//   State<InfiniteScrollHomePage> createState() => _InfiniteScrollHomePageState();
// }

// class _InfiniteScrollHomePageState extends State<InfiniteScrollHomePage> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;
//   int _currentPage = 1;
//   static const int _pageSize = 10;
//   bool _hasReachedMax = false;
//   List<DummyPost> _allPosts = [];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _loadInitialPosts();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent * 0.7 &&
//         !_isLoading &&
//         !_hasReachedMax) {
//       _loadMoreDummyPosts();
//     }
//   }

//   Future<void> _loadInitialPosts() async {
//     setState(() {
//       _currentPage = 1;
//       _hasReachedMax = false;
//       _isLoading = true;
//       _allPosts.clear(); // Ensure old data is cleared only on refresh
//     });

//     await context.read<DummyPostsCubit>().getDummyPosts(
//           FilterDummyPostsReqParams(page: _currentPage, pageSize: _pageSize),
//         );
//   }

//   Future<void> _loadMoreDummyPosts() async {
//     if (_isLoading || _hasReachedMax) return;

//     setState(() {
//       _isLoading = true;
//     });

//     final nextPage = _currentPage + 1;

//     await context.read<DummyPostsCubit>().getDummyPosts(
//           FilterDummyPostsReqParams(page: nextPage, pageSize: _pageSize),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dummy Posts Infinite'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: AdBlocSearchDelegate(
//                   context.read<DummyPostsSearchBloc>(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.search, size: 20),
//           )
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadInitialPosts,
//         child: BlocConsumer<DummyPostsCubit, DummyPostsState>(
//           listener: (context, state) {
//             if (state is DummyPostsLoadSuccessState) {
//               setState(() {
//                 _isLoading = false;

//                 if (_currentPage == 1) {
//                   _allPosts = state.dummyPosts; // Reset only on first load
//                 } else {
//                   _allPosts.addAll(state.dummyPosts); // Append new data
//                 }

//                 if (state.dummyPosts.length < _pageSize) {
//                   _hasReachedMax = true;
//                 } else {
//                   _currentPage++; // Only increase when more data is available
//                 }
//               });
//             } else if (state is DummyPostsLoadFailureState) {
//               setState(() {
//                 _isLoading = false;
//               });

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is DummyPostsLoadingState && _allPosts.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (_allPosts.isEmpty) {
//               return const Center(child: Text('No posts available'));
//             }

//             return ListView.builder(
//               controller: _scrollController,
//               itemCount: _allPosts.length + (_hasReachedMax ? 0 : 1),
//               itemBuilder: (context, index) {
//                 if (index >= _allPosts.length) {
//                   return const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     child: Center(child: CircularProgressIndicator()),
//                   );
//                 }
//                 return DummyPostNewsCard(post: _allPosts[index]);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }










// class InfiniteScrollHomePage extends StatefulWidget {
//   const InfiniteScrollHomePage({super.key});

//   @override
//   State<InfiniteScrollHomePage> createState() => _InfiniteScrollHomePageState();
// }

// class _InfiniteScrollHomePageState extends State<InfiniteScrollHomePage> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;
//   int _currentPage = 1;
//   static const int _pageSize = 10;
//   bool _hasReachedMax = false;
//   List<DummyPost> _allPosts = [];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _loadInitialPosts();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent * 0.7 &&
//         !_isLoading &&
//         !_hasReachedMax) {
//       _loadMoreDummyPosts();
//     }
//   }

// Future<void> _loadInitialPosts() async {
//     setState(() {
//       _currentPage = 1;
//       _hasReachedMax = false;
//       _isLoading = true;
//     });

//     await context.read<DummyPostsCubit>().getDummyPosts(
//           FilterDummyPostsReqParams(page: _currentPage, pageSize: _pageSize),
//         );
//   }


//   Future<void> _loadMoreDummyPosts() async {
//     if (_isLoading || _hasReachedMax) return;

//     setState(() {
//       _isLoading = true;
//       _currentPage++; // Increment page before loading
//     });

//     await context.read<DummyPostsCubit>().getDummyPosts(
//           FilterDummyPostsReqParams(page: _currentPage, pageSize: _pageSize),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dummy Posts Infinite'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: AdBlocSearchDelegate(
//                   context.read<DummyPostsSearchBloc>(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.search, size: 20),
//           )
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadInitialPosts,
//         child: BlocConsumer<DummyPostsCubit, DummyPostsState>(
//           listener: (context, state) {
//             if (state is DummyPostsLoadSuccessState) {
//               setState(() {
//                 _isLoading = false;

//                 if (_currentPage == 1) {
//                   _allPosts = state.dummyPosts;
//                 } else {
//                   _allPosts.addAll(state.dummyPosts);
//                 }

//                 if (state.dummyPosts.length < _pageSize) {
//                   _hasReachedMax = true;
//                 }
//               });
//             } else if (state is DummyPostsLoadFailureState) {
//               setState(() {
//                 _isLoading = false;
//               });

//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             }
//           },
//           builder: (context, state) {
//             // Show loading only on initial load
//             if (state is DummyPostsLoadingState && _allPosts.isEmpty) {
//               return const Center(child: CircularProgressIndicator());
//             }else if (state is DummyPostsLoadSuccessState) {
//               if (_allPosts.isEmpty) {
//                 return const Center(child: Text('No posts available'));
//               }

//               return ListView.builder(
//                 controller: _scrollController,
//                 itemCount: _allPosts.length + (_hasReachedMax ? 0 : 1),
//                 itemBuilder: (context, index) {
//                   if (index >= _allPosts.length) {
//                     return const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   }
//                   return DummyPostNewsCard(post: _allPosts[index]);
//                 },
//               );
//             }else if (state is DummyPostsLoadFailureState) {
//               return Center(child: Text(state.message));
//             } else {
//               return const SizedBox();
//             }                   
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
