import 'package:budget_tracker/model/exception_model.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/model/expense_type_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';

class DatabaseService {
  final MySQLConnectionPool _pool = MySQLConnectionPool(
    host: dotenv.get("DB_HOST"),
    port: dotenv.getInt("DB_PORT"),
    userName: dotenv.get("DB_USER"),
    password: dotenv.get("DB_PASSWORD"),
    databaseName: dotenv.get("DB_NAME"),
    maxConnections: 10,
    secure: false,
  );

  Future<List<ExpenseModel>> getAllExpenses(
    String? month,
    String? year,
  ) async {
    try {
      String query = "SELECT * FROM expenses";
      if (month == null) {
        query += " WHERE MONTH(NOW())=MONTH(date) AND YEAR(NOW())=YEAR(date)";
      } else {
        query += " WHERE MONTH(date)=$month AND YEAR(date)=$year";
      }
      // return expenseToList(await _pool.execute(query));
      return (await _pool.execute(query)).resultSetToList<ExpenseModel>();
    } catch (e) {
      throw Exception(e);
    }
  }

  // List<ExpenseModel> expenseToList(IResultSet res) =>
  //     res.rows.map((e) => ExpenseModel.rowToExpenseModel(e)).toList();

  Future<List<ExpenseTypeModel>> getAllExpenseTypes() async {
    try {
      String query = "SELECT * FROM expensetypes";
      return (await _pool.execute(query)).resultSetToList<ExpenseTypeModel>();
    } catch (e) {
      _pool.close();
      throw Exception(e);
    }
  }
}

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

extension IResultSetExtensions on IResultSet {
  List<T> resultSetToList<T>() {
    dynamic value;
    switch (T) {
      case ExpenseTypeModel:
        value =
            rows.map((e) => ExpenseTypeModel.rowToExpenseTypeModel(e)).toList();
        break;
      case ExpenseModel:
        value = rows.map((e) => ExpenseModel.rowToExpenseModel(e)).toList();
        break;
      default:
        value = null;
        break;
    }
    if (value == null) {
      throw DatabaseConversionException(
          message: "Not a valid model type for IResultSet rows (expected $T)");
    }
    return value as List<T>;
  }
}
