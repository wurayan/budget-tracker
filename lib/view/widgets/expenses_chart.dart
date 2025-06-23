import 'dart:math';

import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesChart extends StatelessWidget {
  ExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, bloc, child) => BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: bloc.sums.values.fold<double>(0, max) * 1.2,
          barTouchData: BarTouchData(enabled: false),
          titlesData: _flTitlesData,
          borderData: FlBorderData(show: false),
          barGroups:
              _barChartRodData(bloc, MediaQuery.sizeOf(context).width * 0.3),
          gridData: FlGridData(
            show: false,
          ),
        ),
      ),
    );
  }

  final FlTitlesData _flTitlesData = FlTitlesData(
    show: true,
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(Responsible.values[value.toInt()].name);
        },
      ),
    ),
  );

  List<BarChartGroupData> _barChartRodData(ExpenseNotifier bloc, double width) {
    return Responsible.values
        .asMap()
        .entries
        .map(
          (e) => BarChartGroupData(
            x: e.key,
            groupVertically: true,
            barsSpace: 1,
            barRods: [
              BarChartRodData(
                toY: bloc.sums[e.value.lowerName()] ?? 0.0,
                width: width,
                borderRadius: BorderRadius.zero,
                rodStackItems: [
                  BarChartRodStackItem(
                    0.0,
                    bloc.monthlyExpenses[e.value.lowerName()] ?? 0.0,
                    Colors.red,
                  ),
                  BarChartRodStackItem(
                    bloc.monthlyExpenses[e.value.lowerName()] ?? 0.0,
                    bloc.sums[e.value.lowerName()] ?? 0.0,
                    Colors.blue,
                  )
                ],
              ),
            ],
          ),
        )
        .toList();
  }
}
