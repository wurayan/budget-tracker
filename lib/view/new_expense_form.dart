import 'package:brasil_fields/brasil_fields.dart';
import 'package:budget_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseForm extends StatefulWidget {
  const NewExpenseForm({super.key});

  @override
  State<NewExpenseForm> createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final Responsible? _selectedUser = null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //TODO começar com foco no valor
  //colocar o usuário abaixo do valor
  //validar a data para salvar no formato correto

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              height: 30,
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'HOJE',
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 2.0),
                ),
                controller: _dateController,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    _dateController.text = UtilData.obterDataDDMMAAAA(picked);
                  }
                },
                onChanged: (value) => _dateController.text = value,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onEditingComplete: () => FocusScope.of(context).unfocus(),
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _dateController.text = DateTime.now()
                        .toString()
                        .replaceAll("00:00:00.000", "");
                  }
                  return null;
                },
                inputFormatters: [DataInputFormatter()],
              ),
            ),
            const SizedBox(height: 16),
            // 2. User dropdown
            DropdownButtonFormField<Responsible>(
              decoration: const InputDecoration(
                labelText: 'User',
                prefixIcon: Icon(Icons.person),
              ),
              items: Responsible.values
                  .map((user) => DropdownMenuItem(
                        value: user,
                        child: Text(user.name),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle user selection (needs stateful widget for real use)
              },
            ),
            const SizedBox(height: 16),
            // 3. Value field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Value',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
  }
}
