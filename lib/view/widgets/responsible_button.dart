import 'package:budget_tracker/model/expense_model.dart';
import 'package:flutter/material.dart';

class ResponsibleButton extends StatefulWidget {
  final Responsible responsible;
  final Function(String value) changeResponsible;
  final bool isActive;
  const ResponsibleButton({
    super.key,
    required this.responsible,
    required this.changeResponsible,
    required this.isActive,
  });

  @override
  State<ResponsibleButton> createState() => _ResponsibleButtonState();
}

class _ResponsibleButtonState extends State<ResponsibleButton> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return OutlinedButton(
      onPressed: () {
        widget.changeResponsible(widget.responsible.name);
        print(widget.isActive);
      },
      style: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.grey[100],
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        side: widget.isActive
            ? const BorderSide(
                width: 5,
                color: Colors.grey,
              )
            : null,
      ),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.45,
        alignment: Alignment.center,
        // clipBehavior: Clip.hardEdge,
        child: Text(
          widget.responsible.name,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
