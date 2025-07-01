class LogModel {
  String error;
  String message;
  String stackTrace;
  DateTime when;

  LogModel({
    required this.error,
    required this.message,
    required this.stackTrace,
    required this.when,
  });

  static LogModel saveLog(Exception e, StackTrace s) => LogModel(
        error: e.runtimeType.toString(),
        message: e.toString(),
        stackTrace: s.toString(),
        when: DateTime.now(),
      );

  static Map<String, dynamic> toMap(LogModel logModel) => {
        "id": null,
        "error": logModel.error,
        "message": logModel.message,
        "stacktrace": logModel.stackTrace,
        "when": logModel.when.toString(),
      };
}
