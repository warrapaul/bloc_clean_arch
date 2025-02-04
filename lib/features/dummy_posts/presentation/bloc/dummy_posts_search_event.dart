part of 'dummy_posts_search_bloc.dart';

@immutable
sealed class DummyPostsSearchEvent {}

final class DummyPostsSearchQueryChanged extends DummyPostsSearchEvent {
  final String query;

  DummyPostsSearchQueryChanged({required this.query});
}

final class DummyPostsClearSearch extends DummyPostsSearchEvent{}