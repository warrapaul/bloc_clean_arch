import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/features/dummy_posts/data/models/filter_dummy_posts_req_params.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_post_by_id.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_posts.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_posts_by_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/search_dummy_posts.dart';
import 'package:meta/meta.dart';

part 'dummy_posts_state.dart';

class DummyPostsCubit extends Cubit<DummyPostsState> {
  final GetDummyPostsUseCase getDummyPostsUseCase;
  final SearchDummyPostsUserCase searchDummyPostsUserCase;
  final GetDummyPostByIdUseCase getDummyPostByIdUseCase;
  final GetDummyPostsByTagUseCase getDummyPostsByTagUseCase;

  DummyPostsCubit({
    required this.getDummyPostsUseCase,
    required this.searchDummyPostsUserCase,
    required this.getDummyPostByIdUseCase,
    required this.getDummyPostsByTagUseCase,
  }) : super(DummyPostsInitialState());


  Future<void> getDummyPosts(FilterDummyPostsReqParams param) async {
    emit(DummyPostsLoadingState());
    final result = await getDummyPostsUseCase(param: param);
    result.fold((error) => emit(DummyPostsLoadFailureState(error: error)),
        (data) => emit(DummyPostsLoadSuccessState(dummyPosts: data)));
  }

  Future<void> searchDummyPosts(FilterDummyPostsReqParams param) async {
    emit(DummyPostsLoadingState());
    final result = await searchDummyPostsUserCase(param: param);
    result.fold((error) => emit(DummyPostsLoadFailureState(error: error)),
        (data) => emit(DummyPostsLoadSuccessState(dummyPosts: data)));
  }

  Future<void> getDummyPostById(int id) async {
    emit(DummyPostsLoadingState());
    final result = await getDummyPostByIdUseCase(param: id);
    result.fold((error) => emit(DummyPostsLoadFailureState(error: error)),
        (data) => emit(DummyPostDetailsLoadSuccessState(dummyPost: data)));
  }

  Future<void> getDummyPostsByTag(FilterDummyPostsReqParams param) async {
    emit(DummyPostsLoadingState());
    final result = await getDummyPostsByTagUseCase(param: param);
    result.fold((error) => emit(DummyPostsLoadFailureState(error: error)),
        (data) => emit(DummyPostsLoadSuccessState(dummyPosts: data)));
  }
}
