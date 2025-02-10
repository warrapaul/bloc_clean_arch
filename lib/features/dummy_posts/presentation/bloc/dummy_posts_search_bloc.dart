import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/core/utility/search_debouncer.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/search_dummy_posts.dart';
import 'package:meta/meta.dart';

part 'dummy_posts_search_event.dart';
part 'dummy_posts_search_state.dart';

class DummyPostsSearchBloc
    extends Bloc<DummyPostsSearchEvent, DummyPostsSearchState> {
  final SearchDummyPostsUserCase searchDummyPostsUserCase;
  final SearchDebouncer _debouncer =
      SearchDebouncer(delay: const Duration(milliseconds: 400));

  DummyPostsSearchBloc({required this.searchDummyPostsUserCase})
      : super(DummyPostsSearchInitial()) {
    on<DummyPostsSearchQueryChanged>(_handleDummyPostsSearchQueryChanged);
    on<DummyPostsClearSearch>(_handleDummyPostsClearSearch);
  }

  Future<void> _handleDummyPostsSearchQueryChanged(
      DummyPostsSearchQueryChanged event,
      Emitter<DummyPostsSearchState> emit) async {
    try {
      final query = event.query.trim();

      if (query.isEmpty) {
        emit(DummyPostsSearchInitial());
        return;
      }

      // // TO DO: confirm if this is necessary
      // if (state is DummyPostsSearchLoading) return; // Prevent duplicate calls
      emit(DummyPostsSearchLoading());

      // Use the debouncer to delay the search
      await _debouncer.run(() async {
        emit(DummyPostsSearchLoading());
        await _performSearch(event.query, emit);
      });

    } catch (e) {
      emit(DummyPostsSearchLoadFailure(message: e.toString()));
    }
  }

  void _handleDummyPostsClearSearch(
      DummyPostsClearSearch event, Emitter<DummyPostsSearchState> emit) {
    _debouncer.cancel();
    emit(DummyPostsSearchInitial());
  }

  Future<void> _performSearch(
      String query, Emitter<DummyPostsSearchState> emit) async {
    final result = await searchDummyPostsUserCase(
        param: FilterDummyPostsReqParams(searchPhrase: query));
    result.fold(
      (failure) => emit(DummyPostsSearchLoadFailure(message: failure.message)),
      (data) => emit(DummyPostsSearchLoadSuccess(dummyPosts: data)),
    );
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    return super.close();
  }
}

