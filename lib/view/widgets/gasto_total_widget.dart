import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GastoTotalWidget extends StatelessWidget {
  const GastoTotalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, bloc, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            UtilBrasilFields.obterReal(
                bloc.sums[Responsible.rayan.name] ?? 0.0),
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.right,
          ),
          Text(
            UtilBrasilFields.obterReal(bloc.sums[Responsible.beau.name] ?? 0.0),
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
