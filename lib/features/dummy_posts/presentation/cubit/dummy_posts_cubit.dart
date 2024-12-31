import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_post_by_id.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_posts.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/search_dummy_posts.dart';
import 'package:meta/meta.dart';

part 'dummy_posts_state.dart';

class DummyPostsCubit extends Cubit<DummyPostsState> {
  final GetDummyPostsUseCase getDummyPostsUseCase;
  final SearchDummyPostsUserCase searchDummyPostsUserCase;
  final GetDummyPostByIdUseCase getDummyPostByIdUseCase;

  DummyPostsCubit( 
      {required this.getDummyPostsUseCase,
      required this.searchDummyPostsUserCase,
      required this.getDummyPostByIdUseCase,
  })
      : super(DummyPostsInitialState());

  Future<void> getDummyPosts(FilterDummyPostsReqParams param) async {
    emit(DummyPostsLoadingState());
    try {
      final result = await getDummyPostsUseCase(param: param);
      result.fold(
          (failure) =>
              emit(DummyPostsLoadFailureState(message: failure.message)),
          (data) => emit(DummyPostsLoadSuccessState(dummyPosts: data)));
    } catch (e) {
      emit(DummyPostsLoadFailureState(message: e.toString()));
    }
  }

  Future<void> searchDummyPosts(FilterDummyPostsReqParams param) async {
    emit(DummyPostsLoadingState());
    try {
      final result = await searchDummyPostsUserCase(param: param);
      result.fold(
          (failure) =>
              emit(DummyPostsLoadFailureState(message: failure.message)),
          (data) => emit(DummyPostsLoadSuccessState(dummyPosts: data)));
    } catch (e) {
      emit(DummyPostsLoadFailureState(message: e.toString()));
    }
  }

  Future<void> getDummyPostById(int id) async {
     emit(DummyPostsLoadingState());
    try {
      final result = await getDummyPostByIdUseCase(param: id);
      result.fold(
          (failure) =>
              emit(DummyPostsLoadFailureState(message: failure.message)),
          (data) => emit(DummyPostDetailsLoadSuccessState(dummyPost: data)));
    } catch (e) {
      emit(DummyPostsLoadFailureState(message: e.toString()));
    }
  }
}
