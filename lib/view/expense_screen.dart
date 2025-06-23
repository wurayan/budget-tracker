import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/view/widgets/expenses_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Consumer<ExpenseNotifier>(
        builder: (context, bloc, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: bloc.isLoading
                  ? Container(
                      height: 50,
                      width: 50,
                      color: Colors.teal,
                    )
                  : Container(
                      height: size.height * 0.5,
                      width: size.width,
                      decoration: const BoxDecoration(
                          // color: Colors.deepOrangeAccent,
                          ),
                      child: ExpensesChart(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
