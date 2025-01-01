import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/entities/dummy_post_tag.dart';
import 'package:bloc_clean_arch/features/dummy_posts/domain/usecases/get_dummy_post_tags.dart';
import 'package:meta/meta.dart';

part 'dummy_post_tags_state.dart';

class DummyPostTagsCubit extends Cubit<DummyPostTagsState> {
  final GetDummyPostTagsUseCase getDummyPostTagsUseCase;
  DummyPostTagsCubit({required this.getDummyPostTagsUseCase})
      : super(DummyPostTagsInitialState());

  Future<void> getDummyPostTags() async {
    emit(DummyPostTagsLoadingState());
    try {
      final result = await getDummyPostTagsUseCase();
      result.fold(
          (failure) =>
              emit(DummyPostTagsLoadFailureState(message: failure.message)),
          (data) => emit(DummyPostTagsLoadSuccessState(tags: data)));
    } catch (e) {
      emit(DummyPostTagsLoadFailureState(message: e.toString()));
    }
  }
}
