import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthExpenseWidget extends StatelessWidget {
  const MonthExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Mês atual",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                UtilBrasilFields.obterReal(
                    bloc.monthlyExpenses[Responsible.rayan.name] ?? 0.0),
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.right,
              ),
              Text(
                UtilBrasilFields.obterReal(
                    bloc.monthlyExpenses[Responsible.beau.name] ?? 0.0),
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          )
        ],
      ),
    );
  }
}
