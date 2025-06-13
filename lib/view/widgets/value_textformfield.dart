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
        color: Colors.amber,
      ),
      child: TextFormField(
        autofocus: true,
        controller: valueController,
        decoration: const InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.black,
            // radius: 5,
            child: Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          counter: null,
          counterText: "",
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
        style: const TextStyle(fontSize: 50),
        onChanged: (value) => valueController.text = value,
        onFieldSubmitted: (value) {
          valueController.text = value;
        },
        onTapOutside: (e) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
