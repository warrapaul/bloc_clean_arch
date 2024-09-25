import 'package:bloc_clean_arch/core/network/dio_execption_handlers.dart';
import 'package:bloc_clean_arch/core/network/interceptors.dart';
import 'package:bloc_clean_arch/resources/constants/api_urls_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
              baseUrl: ApiUrlsConstants.baseUrl,
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10)),
        )
          ..interceptors.addAll([
            LoggerInterceptor(),
            AuthInterceptor(),
          ]);
          // ..interceptors.addAll([
          //   AuthInterceptor(),
          //   if (kDebugMode) LogInterceptor(responseBody: true),
          // ]);

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  
  Future<dynamic> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  CustomNetworkException _handleError(dynamic error) {
    if (error is DioException) {
      return CustomNetworkException.fromDioException(error);
    }
    return CustomNetworkException(
        'An unexpected error occurred: ${error.toString()}');
  }
}
