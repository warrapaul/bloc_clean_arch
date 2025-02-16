class CustomSocketIoException implements Exception {
  final String message;
  final int? statusCode;
  final String? serverMessage;

  CustomSocketIoException({
    required this.message,
    this.statusCode, 
    this.serverMessage,
  });

}