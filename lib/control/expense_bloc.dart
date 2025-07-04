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

  String? error;

  ExpenseNotifier() {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _getExpenseTypes();
      await _getExpenses();
      await _getSums();
      _getMonthlyTotal();
    } catch (e, s) {
      error = "$e\n$s";
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
      _monthlyExpenses[expense.responsible.name] =
          (_monthlyExpenses[expense.responsible.name] ?? 0) + expense.value;
    }
  }

  Future<void> updateExpenses(ExpenseModel expenseModel) async {
    _isLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 10));
    try {
      await _db.saveExpense(expenseModel);
      _expenses.add(expenseModel);
      // double newExpense = double.parse(expenseModel.value.toStringAsFixed(2));
      _updateMap(_monthlyExpenses, expenseModel);
      _updateMap(_sums, expenseModel);
      // _monthlyExpenses[expenseModel.responsible.name] =
      //     (_monthlyExpenses[expenseModel.responsible.name] ?? 0) + newExpense;
      // _sums[expenseModel.responsible.name] =
      //     (_sums[expenseModel.responsible.name] ?? 0) + newExpense;
    } catch (e) {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  void _updateMap(Map<String, double> map, ExpenseModel expenseModel) =>
      map[expenseModel.responsible.name] =
          (map[expenseModel.responsible.name] ?? 0.0) +
              double.parse(expenseModel.value.toStringAsFixed(2));

  //TODO FILTER EXPENSES BY RESPONSIBLE AND MONTH
}
