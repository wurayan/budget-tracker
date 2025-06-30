import 'package:flutter/material.dart';

class SaveExpenseButton extends StatelessWidget {
  final VoidCallback save;
  const SaveExpenseButton({super.key, required this.save});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, right: 16),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
          child: ElevatedButton.icon(
            onPressed: save,
            icon: const Icon(Icons.check),
            label: const Text(
              "Salvar",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(),
          ),
        ),
      ),
    );
  }
}
