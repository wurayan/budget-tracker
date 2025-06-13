import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/view/widgets/date_selector.dart';
import 'package:budget_tracker/view/widgets/description_selector.dart';
import 'package:budget_tracker/view/widgets/user_selector.dart';
import 'package:budget_tracker/view/widgets/value_textformfield.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const NewExpenseForm({super.key, required this.formKey});

  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  // Responsible? _selectedUser = Responsible.beau;
  final TextEditingController _responsibleController =
      TextEditingController(text: Responsible.beau.name);
  final TextEditingController _descriptionController = TextEditingController();

  //TODO começar com foco no valor
  //colocar o usuário abaixo do valor
  //validar a data para salvar no formato correto

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DateSelector(dateController: _dateController),
            const SizedBox(height: 16),
            ValueTextFormField(valueController: _valueController),
            const SizedBox(height: 16),
            UserSelector(responsible: _responsibleController),
            const SizedBox(height: 16),
            DescriptionSelector(descriptionController: _descriptionController),
          ],
        ),
      ),
    );
  }
}
