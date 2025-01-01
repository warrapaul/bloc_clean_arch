part of 'dummy_post_tags_cubit.dart';

@immutable
sealed class DummyPostTagsState {}

final class DummyPostTagsInitialState extends DummyPostTagsState {}

final class DummyPostTagsLoadingState extends DummyPostTagsState {}

final class DummyPostTagsLoadSuccessState extends DummyPostTagsState {
  final List<DummyPostTag> tags;

  DummyPostTagsLoadSuccessState({required this.tags});
}

final class DummyPostTagsLoadFailureState extends DummyPostTagsState {
  final String message;

  DummyPostTagsLoadFailureState({required this.message});
}

