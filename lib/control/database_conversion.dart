import 'package:budget_tracker/model/exception_model.dart';
import 'package:mysql_client/mysql_client.dart';

extension ResultSetRowExtensions on ResultSetRow {
  T get<T>(String columnName) {
    dynamic value;
    switch (T) {
      case int:
        value = typedColByName<int>(columnName);
        break;
      case double:
        value = typedColByName<double>(columnName);
        break;
      default:
        value = typedColByName<String>(columnName);
    }
    if (value == null) {
      throw DatabaseConversionException(
        message: "Missing or null $columnName (expected $T)",
      );
    }
    return value as T;
  }
}
