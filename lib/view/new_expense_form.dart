import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/view/widgets/date_selector.dart';
import 'package:budget_tracker/view/widgets/user_selector.dart';
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
            //TODO PODEMOS MUDAR PARA DOIS BOTÕES PARA CADA USUÁRIO
            UserSelector(responsible: _responsibleController),
            const SizedBox(height: 16),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  prefixIcon: CircleAvatar(
                    backgroundColor: Colors.black,
                    // radius: 5,
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ),
                  ),
                  // suffix: Text(
                  //   "R\$ ",
                  //   textAlign: TextAlign.end,
                  // ),
                  contentPadding: EdgeInsets.zero,
                ),
                expands: true,
                maxLines: null,
                minLines: null,
                textAlign: TextAlign.end,
                textAlignVertical: TextAlignVertical.center,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  CurrencyTextInputFormatter.currency(
                    decimalDigits: 2,
                    enableNegative: false,
                    locale: "pt-br",
                    // symbol: "R\$",
                    // customPattern: "###.###,##",
                  )
                ],
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
