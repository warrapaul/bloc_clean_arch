class SharedPrefException {
  final String message;
  final int? statusCode;

  SharedPrefException({
    required this.message,
    this.statusCode,
  });
}
