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

  Future<BigInt> saveExpense(ExpenseModel expenseModel) async {
    try {
      String query =
          "INSERT INTO expenses (id, description, value, responsible, expenseType,date) VALUES (:id,:description,:value,:responsible,:expenseType,:date)";
      return (await _pool.execute(query, ExpenseModel.toMap(expenseModel)))
          .lastInsertID;
    } catch (e) {
      throw Exception(e);
    }
  }

  //TODO EDITAR EXPENSE
  //TODO CRIAR E EDITAR EXPENSE TYPE

  Future<List<ExpenseTypeModel>> getAllExpenseTypes() async {
    try {
      String query = "SELECT * FROM expensetypes";
      return (await _pool.execute(query)).resultSetToList<ExpenseTypeModel>();
    } catch (e) {
      _pool.close();
      throw Exception(e);
    }
  }

  Future<Map<String, double>> getExpenseSum() async {
    try {
      // Map<String, double> sums = {};
      String query =
          "SELECT SUM(VALUE) as soma, responsible FROM expenses GROUP BY responsible";
      // IResultSet res = await _pool.execute(query);
      // for (var row in res.rows) {
      //   sums[row.get<String>("responsible")] = row.get<double>("soma");
      // }
      // return sums;
      return {
        for (var row in (await _pool.execute(query)).rows)
          row.get<String>("responsible"): row.get<double>("soma")
      };
    } catch (e) {
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
        value = double.parse(colByName(columnName)??"0");
        break;
      case DateTime:
        String? v = typedColByName<String>(columnName);
        value = v == null ? null : DateTime.parse(v);
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
      case const (ExpenseTypeModel):
        value =
            rows.map((e) => ExpenseTypeModel.rowToExpenseTypeModel(e)).toList();
        break;
      case const (ExpenseModel):
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
