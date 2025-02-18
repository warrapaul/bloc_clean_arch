import 'package:bloc_clean_arch/core/constants/api_urls_constants.dart';
import 'package:bloc_clean_arch/core/network/auth_token_manager.dart';
import 'package:bloc_clean_arch/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;

    try {
      final responseData = err.response?.data;
      final message = responseData is Map ? responseData['message'] : null;    // Extract server message if available
      final serverMessage = message is List    // if msg is a list convert to string
          ? message.join(', ')
          : message?.toString() ?? "No server message";

      logger.e('''
          HTTP REQUEST ERROR
          URL: ${options.baseUrl}${options.path}
          Method: ${options.method}
          Payload: ${options.data ?? "No Payload"}
          Server Message: ${serverMessage ?? "No server message"}
          Error Type: ${err.type}
          Response: ${err.response?.data}

          Error Message: ${err.message}
      ''');

      handler.next(err);
    } catch (e, stackTrace) {
      logger.e('''
          HTTP REQUEST ERROR: u
          URL: ${options.baseUrl}${options.path}
          Method: ${options.method}
          Error Type: ${err.type}
          Response: ${err.response?.data}
          
          Payload: ${options.data ?? "No Payload"}
          Error Message: ${err.message}
          Error in onError: $e       
          Stack trace: $stackTrace   
      '''); 

      handler.next(err); 
    }
  }



  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('''
        OUTGOING HTTP REQUEST
        URL: ${options.baseUrl}${options.path}
        Method: ${options.method}
        Payload: ${options.data ?? "No Payload"}
        Query Parameters: ${options.queryParameters}
    ''');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('''
      HTTP RESPONSE
      Status: ${response.statusCode} - ${response.statusMessage}
      Data: uncomment onResponse in Logger Interceptor
    '''); //Data: ${response.data}

    handler.next(response);
  }
}

class AuthInterceptor extends Interceptor {
  final _tokenManager = sl<AuthTokenManager>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // CONTROL ROUTES THAT UNAUTHENTICATED USER CAN ACCESS (GoRouter redirect for screens)
    // Check if the current path is in public URLs
    if (ApiUrlsConstants.publicUrls.contains(options.path)) {
      return handler.next(options);
    }

    final token = await _tokenManager.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

class NewsApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (ApiUrlsConstants.newsApiRoutes.contains(options.path)) {
      // ADD TO HEADERS
      // options.headers['Authorization'] = 'Bearer ${ApiUrlsConstants.newsApiKey}';

      // ADD AS PARAM e.g &apiKey=d82...
      options.queryParameters['apiKey'] = ApiUrlsConstants.newsApiKey;
    }
    handler.next(options);
  }
}
