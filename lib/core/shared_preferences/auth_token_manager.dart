import 'package:bloc_clean_arch/core/shared_preferences/shared_pref_exception.dart';
import 'package:bloc_clean_arch/core/shared_preferences/shared_pref_logger.dart';
import 'package:bloc_clean_arch/features/auth/data/models/auth_model.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final _secureStorage = sl<FlutterSecureStorage>();
  final _logger = SharedPrefsLogger();

  Future<bool> saveToken(AuthModel authModel) async {
    final keys = [_accessTokenKey, _refreshTokenKey];
    
    try {
      await Future.wait([
        _secureStorage.write(
            key: _accessTokenKey, value: authModel.accessToken),
        _secureStorage.write(
            key: _refreshTokenKey, value: authModel.refreshToken),
      ]);
      // _logger.logWrite(_accessTokenKey, authModel.accessToken);
      // _logger.logWrite(_refreshTokenKey, authModel.refreshToken);

      _logger.logBatchOperation('saveToken', keys);
      return true;
    } catch (e) {
      _logger.logBatchError('saveToken', keys, e.toString());
      throw SharedPrefException(
        message: 'Failed to save tokens: ${e.toString()}',
      );
    }
  }

  Future<String?> getAccessToken() async {    
    try {
      final token = await _secureStorage.read(key: _accessTokenKey);
      _logger.logRead(_accessTokenKey, token);
      return token;
    } catch (e) {
      _logger.logError('getAccessToken', _accessTokenKey, e.toString());
      throw SharedPrefException(
        message: 'Failed to retrieve access token: ${e.toString()}',
      );
    }
  }

  Future<String?> getRefreshToken() async {   
    try {
      final token = await _secureStorage.read(key: _refreshTokenKey);
      _logger.logRead(_refreshTokenKey, token);
      return token;
    } catch (e) {
      _logger.logError('getRefreshToken', _refreshTokenKey, e.toString());
      throw SharedPrefException(
        message: 'Failed to retrieve refresh token: ${e.toString()}',
      );
    }
  }

  Future<bool> deleteToken() async {
    final keys = [_accessTokenKey, _refreshTokenKey];    
    try {
      await Future.wait([
        _secureStorage.delete(key: _accessTokenKey),
        _secureStorage.delete(key: _refreshTokenKey),
      ]);
      
      _logger.logBatchOperation('deleteToken', keys);
      return true;
    } catch (e) {
      _logger.logBatchError('deleteToken', keys, e.toString());
      throw SharedPrefException(
        message: 'Failed to delete tokens: ${e.toString()}',
      );
    }
  }

  Future<bool> hasToken() async {    
    try {
      final accessToken = await getAccessToken();
      final result = accessToken != null;
      return result;
    } catch (e) {
      throw SharedPrefException(
        message: 'Failed to check token existence: ${e.toString()}',
      );
    }
  }
}


