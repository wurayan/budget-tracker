import 'package:budget_tracker/view/widgets/expenses_chart.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: size.height * 0.5,
              width: size.width * 0.9,
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              child: const ExpensesChart(),
            ),
          )
        ],
      ),
    );
  }
}
