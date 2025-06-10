import 'package:budget_tracker/model/expense_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class UserSelector extends StatefulWidget {
  final TextEditingController responsible;
  const UserSelector({super.key, required this.responsible});

  @override
  State<UserSelector> createState() => _UserSelectorState();
}

class _UserSelectorState extends State<UserSelector> {
  Responsible _responsible = Responsible.beau;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButton2(
        items: Responsible.values
            .map(
              (user) => DropdownMenuItem(
                value: user,
                child: Text(user.name),
              ),
            )
            .toList(),
        isExpanded: true,
        value: _responsible,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              widget.responsible.text = value.name;
              _responsible = value;
            });
          }
        },
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
