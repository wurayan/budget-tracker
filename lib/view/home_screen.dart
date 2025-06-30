import 'package:budget_tracker/view/bottom_draggable_sheet.dart';
import 'package:budget_tracker/view/expense_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Dinheirinhos"),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.blue[100],
      body: const ExpenseScreen(),
      bottomSheet: const BottomDraggableSheet(),
    );
  }
}
