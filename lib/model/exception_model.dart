class DatabaseConversionException implements Exception {
  final String message;
  DatabaseConversionException({required this.message});

  @override
  String toString() => "Exception when converting data from database: $message";
}
