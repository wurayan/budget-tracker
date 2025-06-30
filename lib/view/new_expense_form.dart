import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/control/expense_bloc.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/view/widgets/date_selector.dart';
import 'package:budget_tracker/view/widgets/description_selector.dart';
import 'package:budget_tracker/view/widgets/save_expense_button.dart';
import 'package:budget_tracker/view/widgets/user_selector.dart';
import 'package:budget_tracker/view/widgets/value_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewExpenseForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback collapseForm;
  const NewExpenseForm(
      {super.key, required this.formKey, required this.collapseForm});

  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final TextEditingController _dateController =
      TextEditingController(text: UtilData.obterDataDDMMAAAA(DateTime.now()));
  final TextEditingController _valueController = TextEditingController();
  // Responsible? _selectedUser = Responsible.beau;
  final TextEditingController _responsibleController =
      TextEditingController(text: Responsible.beau.name);
  final TextEditingController _descriptionController = TextEditingController();

  //validar a data para salvar no formato correto

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          DateSelector(dateController: _dateController),
          Divider(color: Colors.blueGrey[800],),
          const SizedBox(height: 16),
          ValueTextFormField(valueController: _valueController),
          const SizedBox(height: 16),
          UserSelector(responsible: _responsibleController),
          const SizedBox(height: 16),
          DescriptionSelector(descriptionController: _descriptionController),
          const Expanded(child: SizedBox()),
          SaveExpenseButton(
            save: () async {
              await Provider.of<ExpenseNotifier>(context, listen: false)
                  .updateExpenses(
                ExpenseModel(
                  id: null,
                  description: _descriptionController.text,
                  value: double.tryParse(_valueController.text
                          .replaceAll('R\$', '')
                          .replaceAll('.', '')
                          .replaceAll(',', '.')) ??
                      0.0,
                  responsible:
                      Responsible.fromName(_responsibleController.text),
                  expenseType: 1,
                  date: UtilData.obterDateTime(_dateController.text),
                ),
              );
              widget.collapseForm();
            },
          ),
        ],
      ),
    );
  }
}
