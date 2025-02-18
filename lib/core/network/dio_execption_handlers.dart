import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? serverMessage;
  final dynamic error;
  final StackTrace? stackTrace;

  ApiException({
    required this.message,
    this.statusCode,
    this.serverMessage,
    this.error,
    this.stackTrace,
  });

  factory ApiException.fromDioException(DioException error) {
    String message;
    String? serverMessage;
    int? statusCode = error.response?.statusCode;

    try {
      if (error.response?.data is Map) {
        if (error.response?.data['message'] is List) {
          serverMessage = (error.response?.data['message'] as List)
              .map((e) => e.toString())
              .join(', ');
        } else if (error.response?.data['message'] is String) {
          serverMessage = error.response?.data['message'] as String;
        } else if (error.response?.data['error'] is String) {
          serverMessage = error.response?.data['error'] as String;
        }
      }
    } catch (e) {
      serverMessage = error.response?.data?.toString();
    }

    if (statusCode != null) {
      message = _getMessageFromStatusCode(statusCode);
    } else {
      // If no status code, fall back to error type handling
      message = switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout =>
          'Connection timed out',
        DioExceptionType.badResponse => 'Bad response from server',
        DioExceptionType.cancel => 'Request was cancelled',
        DioExceptionType.connectionError =>
          'Connection error. Unable to reach the server',
        DioExceptionType.unknown => error.message ?? 'An unexpected error occurred',
        _ => 'An unexpected error occurred'
      };
    }

    return ApiException(
      message: serverMessage ?? message,
      statusCode: statusCode,
      serverMessage: serverMessage,
      error: error,
      stackTrace: error.stackTrace,
    );
  }


  static String _getMessageFromStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => "Invalid request. Please check your input.",
      401 => "Unauthorized. Please login again.",
      403 => "Forbidden. You don't have permission to access this resource.",
      404 => "The requested resource was not found.",
      500 => "Internal server error. Please try again later.",
      _ => "Oops! Something went wrong. Please try again.",
    };
  }

  @override
  String toString() {
    return '''
      ApiException:
      Status Code: ${statusCode ?? 'N/A'}
      Message: $message
      Server Message: ${serverMessage ?? 'N/A'}
      Error Details: ${error?.toString() ?? 'N/A'}
    ''';
    }
}



// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final String? serverMessage;

//   ApiException({required this.message, this.statusCode, this.serverMessage});

// // if (error is ApiException) {
// //       return ApiFailure(
// //         message: error.message,
// //         statusCode: error.statusCode,
// //       );
// //     }

// //     if (error is DioException) {

//   factory ApiException.fromDioException(DioException error) {
//     String message;
//     int? statusCode = error.response?.statusCode;
//     String? serverMessage = error.response?.data['error'] as String?;

// print('DioException type: ${error.type}');
//     print('Status code: $statusCode');
//     print('Error message: ${error.message}');

//     if (error.response?.data['message'] is List) {
//       // Handle list of messages
//       final messages = (error.response?.data['message'] as List)
//           .map((e) => e.toString())
//           .join(', ');
//       serverMessage = 'Error: $messages';
//     } else if (error.response?.data['message'] is String) {
//       // Handle string message
//       serverMessage = error.response?.data['message'] as String;
//     } else if (error.response?.data['error'] is String) {
//       serverMessage = error.response?.data['error'] as String;
//     } 

//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         message = 'Connection timed out';
//         break;
//       case DioExceptionType.badResponse:
//         message = _getMessageFromStatusCode(statusCode);
//         break;
//       case DioExceptionType.cancel:
//         message = 'Request was cancelled';
//         break;
//       case DioExceptionType.connectionError:
//         message = 'Connection error. Unable to reach the server';
//         break;
//       case DioExceptionType.unknown:
//       default:
//         message = 'An unexpected error occurred';
//         break;
//     }

//     return ApiException(
//       message: serverMessage ?? message,
//       statusCode: statusCode,
//     );
//   }

//   static String _getMessageFromStatusCode(int? statusCode) {
//     return switch (statusCode) {
//       400 => "Invalid request. Please check your input.",
//       401 => "Unauthorized. Please login again.",
//       403 => "Forbidden. You don't have permission to access this resource.",
//       404 => "The requested resource was not found.",
//       500 => "Internal server error. Please try again later.",
//       _ => "Oops! Something went wrong. Please try again.",
//     };
//   }

//   // @override
//   // String toString() {
//   //   return 'ApiException: $message'
//   //       '${statusCode != null ? ' (Status Code: $statusCode)' : ''}'
//   //       '${serverMessage != null ? ' - Server message: $serverMessage' : ''}';
//   // }
// }
