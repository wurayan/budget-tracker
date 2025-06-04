import 'package:budget_tracker/control/database_conversion.dart';
import 'package:mysql_client/mysql_client.dart';

enum Responsible {
  rayan,
  beau,
}

class ExpenseModel {
  int id;
  String description;
  double value;
  Responsible responsible;
  int expenseType;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.value,
    required this.responsible,
    required this.expenseType,
  });

  static ExpenseModel rowToExpenseModel(ResultSetRow row) => ExpenseModel(
        id: row.get<int>("id"),
        description: row.get("description"),
        value: row.get<double>("value"),
        responsible: row.get("responsible"),
        expenseType: row.get<int>("type"),
      );
}
