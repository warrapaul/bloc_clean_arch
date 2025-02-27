import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  static const String onboardingCompletedKey = 'onboarding_completed';
  final SharedPreferences _sharedPreferences;

  OnboardingLocalDataSourceImpl({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;
  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      return _sharedPreferences.getBool(onboardingCompletedKey) ?? false;
    } catch (e) {
      throw Exception('Failed to get onboarding status');
    }
  }

  @override
  Future<void> setOnboardingCompleted() async {
    try {
      await _sharedPreferences.setBool(onboardingCompletedKey, true);
    } catch (e) {
      throw Exception('Failed to set onboarding status');
    }
  }
}
