part of 'dummy_posts_search_bloc.dart';

@immutable
sealed class DummyPostsSearchState {}

final class DummyPostsSearchInitial extends DummyPostsSearchState {}


final class DummyPostsSearchLoading extends DummyPostsSearchState {}

final class DummyPostsSearchLoadSuccess extends DummyPostsSearchState {
  final List<DummyPost> dummyPosts;

  DummyPostsSearchLoadSuccess({required this.dummyPosts});
}

final class DummyPostsSearchLoadFailure extends DummyPostsSearchState {
  final String message;

  DummyPostsSearchLoadFailure({required this.message});
}
