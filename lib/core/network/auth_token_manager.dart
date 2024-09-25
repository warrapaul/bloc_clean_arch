import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenManager {
  static const String _tokenKey = 'access_token';
  final _secureStorage = sl<FlutterSecureStorage>();


  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    return await getToken() != null;
  }
}
