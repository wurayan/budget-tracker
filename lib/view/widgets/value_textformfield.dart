import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class ValueTextFormField extends StatelessWidget {
  final TextEditingController valueController;

  const ValueTextFormField({super.key, required this.valueController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.1,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          // color: Colors.amber,
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          autofocus: true,
          controller: valueController,
          decoration: InputDecoration(
            prefixIcon: CircleAvatar(
              backgroundColor: Colors.blueGrey[800],
              // radius: 5,
              child: Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            counter: null,
            counterText: "",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            // helperText: "R\$ 0",
            hintText: "R\$ 0,00",
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          expands: true,
          maxLines: null,
          minLines: null,
          maxLength: 13,
          textAlign: TextAlign.end,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            CurrencyTextInputFormatter.currency(
              decimalDigits: 2,
              enableNegative: false,
              locale: "pt-br",
              symbol: "R\$",
              // customPattern: "###.###,##",
            )
          ],
          style: const TextStyle(
            fontSize: 50,
            color: Colors.black,
          ),
          onChanged: (value) => valueController.text = value,
          onFieldSubmitted: (value) {
            valueController.text = value;
          },
          onTapOutside: (e) => FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }
}
