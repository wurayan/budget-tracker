import 'dart:collection';
import 'dart:io';

import 'package:budget_tracker/control/database.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/model/expense_type_model.dart';
import 'package:flutter/material.dart';

class ExpenseNotifier with ChangeNotifier {
  List<ExpenseModel> _expenses = [];
  UnmodifiableListView<ExpenseModel> get expenses =>
      UnmodifiableListView(_expenses);

  List<ExpenseTypeModel> _expenseTypes = [];
  UnmodifiableListView<ExpenseTypeModel> get expenseTypes =>
      UnmodifiableListView(_expenseTypes);

  Map<String, double> _sums = {};
  UnmodifiableMapView<String, double> get sums =>
      UnmodifiableMapView<String, double>(_sums);

  final Map<String, double> _monthlyExpenses = {
    for (var e in Responsible.values) e.name.toLowerCase(): 0.0
  };
  UnmodifiableMapView<String, double> get monthlyExpenses =>
      UnmodifiableMapView(_monthlyExpenses);

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
      print("Got expense types $_expenseTypes");
      await _getExpenses();
      print("Got Expenses $_expenses");
      await _getSums();
      print("Got Sums $_sums");
      _getMonthlyTotal();
      print("Got monthly sums $_monthlyExpenses");
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

  Future<void> _getSums() async {
    _sums = await _db.getExpenseSum();
  }

  void _getMonthlyTotal() {
    for (var expense in _expenses) {
      _monthlyExpenses[expense.responsible.lowerName()] =
          (_monthlyExpenses[expense.responsible.lowerName()] ?? 0) +
              expense.value;
    }
  }

  Future<void> updateExpenses(ExpenseModel expenseModel) async {
    print("UPDATING");
    _isLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 10));
    try {
      await _db.saveExpense(expenseModel);
      _expenses.add(expenseModel);
      _monthlyExpenses[expenseModel.responsible.name] =
          (_sums[expenseModel.responsible.name] ?? 0) + expenseModel.value;
      _sums[expenseModel.responsible.name] =
          (_sums[expenseModel.responsible.name] ?? 0) + expenseModel.value;
    } catch (e) {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  // Future<void> newExpense(ExpenseModel expenseModel) async {
  //   await _db.saveExpense(expenseModel);
  //   updateExpenses(expenseModel);
  // }

  //TODO FILTER EXPENSES BY RESPONSIBLE AND MONTH
  //TODO INSERT EXPENSE AND RELOAD
}
