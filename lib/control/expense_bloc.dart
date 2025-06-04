import 'dart:collection';

import 'package:budget_tracker/control/database.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/model/expense_type_model.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier with ChangeNotifier {
  List<ExpenseModel> _expenses = [];
  UnmodifiableListView<ExpenseModel> get expenses =>
      UnmodifiableListView(_expenses);

  List<ExpenseTypeModel> _expenseTypes = [];
  List<ExpenseTypeModel> get expenseTypes => _expenseTypes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final DatabaseService _db = DatabaseService();

  ExpenseNotifier() {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _getExpenseTypes();
      await _getExpenses();
    } catch (e) {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _getExpenses() async {
    _expenses = await _db.getAllExpenses(null, null);
  }

  Future<void> _getExpenseTypes() async {
    _expenseTypes = await _db.getAllExpenseTypes();
  }

  //TODO FILTER EXPENSES BY RESPONSIBLE AND MONTH
  //TODO INSERT EXPENSE AND RELOAD
  
}
