import 'package:dio/dio.dart';

class CustomNetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? serverMessage;

  CustomNetworkException(this.message, {this.statusCode, this.serverMessage});

  factory CustomNetworkException.fromDioException(DioException error) {
    String message;
    int? statusCode = error.response?.statusCode;
    String? serverMessage = error.response?.data['error'] as String?;
 
    if (error.response?.data['message'] is List) {
      // Handle list of messages
      final messages = (error.response?.data['message'] as List)
          .map((e) => e.toString())
          .join(', ');
      serverMessage = 'Error: $messages';
    } else if (error.response?.data['message'] is String) {
      // Handle string message
      serverMessage = error.response?.data['message'] as String;
    } else {
      // Fallback to default message
      serverMessage = serverMessage ?? _getMessageFromStatusCode(statusCode);
    }


    // String? serverMessage = error.response?.data['message'] as String?;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timed out';
        break;
      case DioExceptionType.badResponse:
        message = _getMessageFromStatusCode(statusCode);
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error';
        break;
      case DioExceptionType.unknown:
      default:
        message = 'An unexpected error occurred';
        // if (error.error is SocketException) {
        //   message = 'No internet connection';
        // }
        break;
    }

    return CustomNetworkException(
      serverMessage ?? message,  //show server message else show created msg
      statusCode: statusCode, 
      // serverMessage: serverMessage
    );
  }

  static String _getMessageFromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => "Bad request. Please check your input.",
      401 => "Unauthorized. Please login again.",
      403 => "Forbidden. You don't have permission to access this resource.",
      404 => "The requested resource was not found.",
      500 => "Internal server error. Please try again later.",
      _ => "Oops! Something went wrong. Please try again.",
    };
  }

  @override
  String toString() {
    return 'NetworkException: $message'
        '${statusCode != null ? ' (Status Code: $statusCode)' : ''}'
        '${serverMessage != null ? ' - Server message: $serverMessage' : ''}';
  }
}


