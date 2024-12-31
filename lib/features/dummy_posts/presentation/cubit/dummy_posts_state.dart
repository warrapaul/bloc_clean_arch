part of 'dummy_posts_cubit.dart';

@immutable
sealed class DummyPostsState {}

final class DummyPostsInitialState extends DummyPostsState {}

final class DummyPostsLoadingState extends DummyPostsState {}

final class DummyPostsLoadSuccessState extends DummyPostsState {
  final List<DummyPost> dummyPosts;

  DummyPostsLoadSuccessState({required this.dummyPosts});
}

final class DummyPostsLoadFailureState extends DummyPostsState {
  final String message;

  DummyPostsLoadFailureState({required this.message});
}

final class DummyPostDetailsLoadSuccessState extends DummyPostsState {
  final DummyPost dummyPost;

  DummyPostDetailsLoadSuccessState({required this.dummyPost});
}
