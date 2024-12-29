import 'package:bloc_clean_arch/features/on_boarding/domain/usecases/check_onboarding_status.dart';
import 'package:bloc_clean_arch/features/on_boarding/domain/usecases/complete_onboarding.dart';
import 'package:bloc_clean_arch/features/on_boarding/presentation/cubit/onboarding_state.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CheckOnboardingStatusUseCase checkOnboardingStatus;
  final CompleteOnboardingUseCase completeOnboarding;

  OnboardingCubit({
    required this.checkOnboardingStatus,
    required this.completeOnboarding,
  }) : super(OnboardingInitial());

  Future<void> checkStatus() async {
    try {
      final result = await checkOnboardingStatus();

      result.fold(
        (failure) => emit(OnboardingError(failure.message)),
        (isCompleted) {
          if (isCompleted) {
            emit(OnboardingCompleted());
          }
        },
      );
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> complete() async {
    try {
      final result = await completeOnboarding();

      result.fold(
        (failure) => emit(OnboardingError(failure.message)),
        (_) => emit(OnboardingCompleted()),
      );
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
