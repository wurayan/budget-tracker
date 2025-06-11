import 'package:budget_tracker/model/expense_model.dart';
import 'package:budget_tracker/view/widgets/responsible_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class UserSelector extends StatefulWidget {
  final TextEditingController responsible;
  const UserSelector({super.key, required this.responsible});

  @override
  State<UserSelector> createState() => _UserSelectorState();
}

class _UserSelectorState extends State<UserSelector> {
  changeResponsible(String value) {
    widget.responsible.text = value;
    // _isActive = true;
    setState(() {});
    print(widget.responsible.text);
  }

  // bool _isActive = false;
  bool _isActive(Responsible responsible) =>
      widget.responsible.text == responsible.name;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ResponsibleButton(
            responsible: Responsible.beau,
            changeResponsible: changeResponsible,
            isActive: _isActive(Responsible.beau),
          ),
          ResponsibleButton(
            responsible: Responsible.rayan,
            changeResponsible: changeResponsible,
            isActive: _isActive(Responsible.rayan),
          ),
        ],
      ),
    )

        // Container(
        //   height: 30,
        //   width: MediaQuery.of(context).size.width * 0.5,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(50),
        //   ),
        //   child: DropdownButton2(
        //     items: Responsible.values
        //         .map(
        //           (user) => DropdownMenuItem(
        //             value: user,
        //             child: Text(user.name),
        //           ),
        //         )
        //         .toList(),
        //     isExpanded: true,
        //     value: _responsible,
        //     onChanged: (value) {
        //       if (value != null) {
        //         setState(() {
        //           widget.responsible.text = value.name;
        //           _responsible = value;
        //         });
        //       }
        //     },
        //     dropdownStyleData: DropdownStyleData(
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //     ),
        //   ),
        // )

        ;
  }
}
