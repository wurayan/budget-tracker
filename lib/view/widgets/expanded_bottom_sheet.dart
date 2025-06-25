import 'package:budget_tracker/view/new_expense_form.dart';
import 'package:flutter/material.dart';

class ExpandedBottomSheet extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback collapseForm;
  const ExpandedBottomSheet({super.key, required this.formKey, required this.collapseForm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      // padding: const EdgeInsets.all(16.0),
      color: Colors.teal,
      child: NewExpenseForm(
        formKey: formKey,
        collapseForm: collapseForm,
      ),
    );
  }
}
