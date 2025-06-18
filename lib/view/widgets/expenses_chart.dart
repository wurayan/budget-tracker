import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesChart extends StatelessWidget {
  const ExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0),
          BarChartGroupData(x: 1),
        ]
      )
    );
  }
}