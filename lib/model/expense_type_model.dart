import 'package:budget_tracker/control/database.dart';
import 'package:mysql_client/mysql_client.dart';

class ExpenseTypeModel {
  int id;
  String type;
  //TODO adicionar aqui um campo de cor para que o usuário possa escolher a cor dos tipos de gastos

  ExpenseTypeModel({
    required this.id,
    required this.type,
  });

  static ExpenseTypeModel rowToExpenseTypeModel(ResultSetRow row) =>
      ExpenseTypeModel(
        id: row.get<int>("id"),
        type: row.get("typeName"),
      );

  @override
  String toString() => "$id $type\n";
}
