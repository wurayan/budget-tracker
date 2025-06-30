import 'package:budget_tracker/control/database.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

enum Responsible {
  rayan(),
  beau();

  // final Color color;
  const Responsible();

  static Responsible fromName(String name) => Responsible.values.firstWhere(
        (r) => r.name.toLowerCase() == name.toLowerCase(),
        orElse: () =>
            throw ArgumentError("No responsible found with this name -> $name"),
      );
}

extension ResponsibleX on Responsible {
  String get displayName =>
      "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
  Color get color =>
      this == Responsible.rayan ? Colors.green[400]! : Colors.purple[400]!;
  Color get bgColor =>
      this == Responsible.rayan ? Colors.green[200]! : Colors.purple[200]!;
}

class ExpenseModel {
  int? id;
  String description;
  double value;
  Responsible responsible;
  int expenseType;
  DateTime date;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.value,
    required this.responsible,
    required this.expenseType,
    required this.date,
  });

  static ExpenseModel rowToExpenseModel(ResultSetRow row) => ExpenseModel(
        id: row.get<int>("id"),
        description: row.get("description"),
        value: row.get<double>("value"),
        responsible: Responsible.fromName(row.get("responsible")),
        expenseType: row.get<int>("expenseType"),
        date: row.get<DateTime>("date"),
      );
  static Map<String, dynamic> toMap(ExpenseModel expenseModel) => {
        "id": expenseModel.id,
        "description": expenseModel.description,
        "value": expenseModel.value,
        "responsible": expenseModel.responsible.name.toLowerCase(),
        "expenseType": expenseModel.expenseType,
        "date": expenseModel.date,
      };
}
