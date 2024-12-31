import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dummy_posts_state.dart';

class DummyPostsCubit extends Cubit<DummyPostsState> {
  DummyPostsCubit() : super(DummyPostsInitial());
}
