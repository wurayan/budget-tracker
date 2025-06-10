import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final TextEditingController dateController;

  const DateSelector({
    super.key,
    required this.dateController,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        controller: widget.dateController,
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
            widget.dateController.text = UtilData.obterDataDDMMAAAA(picked);
          }
        },
        onChanged: (value) => widget.dateController.text = value,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onEditingComplete: () => FocusScope.of(context).unfocus(),
        onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            widget.dateController.text =
                DateTime.now().toString().replaceAll("00:00:00.000", "");
          }
          return null;
        },
        inputFormatters: [DataInputFormatter()],
      ),
    );
  }
}
