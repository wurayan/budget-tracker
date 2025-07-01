import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/view/widgets/expenses_chart.dart';
import 'package:budget_tracker/view/widgets/gasto_total_widget.dart';
import 'package:budget_tracker/view/widgets/month_expense_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Consumer<ExpenseNotifier>(
        builder: (context, bloc, child) {
          if (bloc.error != null) {
            return Center(
              child: Text(bloc.error!),
            );
          }
          return bloc.isLoading
              ? Center(
                  child: SpinKitWave(
                    color: Colors.pink[200],
                    size: 50,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.5,
                        width: size.width,
                        decoration: const BoxDecoration(
                            // color: Colors.deepOrangeAccent,
                            ),
                        child: ExpensesChart(),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    GastoTotalWidget(),
                    SizedBox(
                      height: 24,
                    ),
                    MonthExpenseWidget(),
                  ],
                );
        },
      ),
    );
  }
}
