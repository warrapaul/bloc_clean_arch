import 'package:bloc_clean_arch/core/configs/routes/app_routes.dart';
import 'package:bloc_clean_arch/core/network/auth_token_manager.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    
    // Log error details, including server message if available
    var message = err.response?.data['message'];
    String? serverMessage;
    if (message is List) {
      serverMessage = message.join(', '); // Convert list to a single string
    } else if (message is String) {
      serverMessage = message; // Already a string, no need to change
    }

//Error log
      logger.e(
        '${options.method} request ==> $requestPath\n'
        'Server message: ${serverMessage ?? "No server message"}\n'
        'Payload: ${options.data ?? "No Payload"}'
      );

    //Debug log
    logger.d('Error type: ${err.error} \n'
        'Error message: ${err.message} \n'
    );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Debug log
    handler.next(response);
  }
}

class AuthInterceptor extends Interceptor {
  final _tokenManager = sl<AuthTokenManager>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (AppRoutes.publicRoutes.contains(options.path)) {
      return handler.next(options);
    }

    final token = await _tokenManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
