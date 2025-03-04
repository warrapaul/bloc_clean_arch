import 'package:bloc_clean_arch/core/shared_preferences/auth_token_manager.dart';
import 'package:bloc_clean_arch/service_locator.dart';

abstract class AuthaLocalService {
  Future<bool> isLoggedIn();
  Future<void> logout();
}

class AuthaLocalServiceImpl extends AuthaLocalService {
  final AuthTokenManager _authTokenManager = sl<AuthTokenManager>();

  @override
  Future<bool> isLoggedIn() async {
    return await _authTokenManager.hasToken();
  }

  @override
  Future<void> logout() async {
    await _authTokenManager.deleteToken();
  }
}



// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// abstract class AuthaLocalService {
//   Future<bool> isLoggedIn();
//   Future<void> logout();
// }

// class AuthaLocalServiceImpl extends AuthaLocalService {
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   @override
//   Future<bool> isLoggedIn() async {
//     String? token = await _secureStorage.read(key: 'access_token');
//     return token != null;
//   }

//   @override
//   Future<void> logout() async {
//     await _secureStorage.delete(key: 'access_token');
//   }
// }
