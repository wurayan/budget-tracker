import 'package:budget_tracker/control/database.dart';
import 'package:budget_tracker/model/expense_type_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue[300],
            width: 200,
            height: 100,
          ),
          Container(
            color: Colors.pink[200],
            width: 200,
            height: 100,
          ),
          Container(
            color: Colors.white,
            width: 200,
            height: 100,
          ),
          ElevatedButton(
            onPressed: () async {
              DatabaseService db = DatabaseService();
              List<ExpenseTypeModel> list = await db.getAllExpenseTypes();
              list.forEach((element) => print(element));
            },
            child: const Text("clica"),
          )
        ],
      ),
    );
  }
}
