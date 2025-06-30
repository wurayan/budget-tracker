import 'package:budget_tracker/utils/dummy_data.dart';
import 'package:budget_tracker/view/widgets/description_chip.dart';
import 'package:flutter/material.dart';

class DescriptionSelector extends StatefulWidget {
  final TextEditingController descriptionController;
  const DescriptionSelector({super.key, required this.descriptionController});

  @override
  State<DescriptionSelector> createState() => _DescriptionSelectorState();
}

class _DescriptionSelectorState extends State<DescriptionSelector> {
  void _selectChip(String value) =>
      setState(() => widget.descriptionController.text = value);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.05,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.amber,
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 1,
                  color: Colors.blueGrey[600]!,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: widget.descriptionController,
                decoration: InputDecoration(
                  hintText: "Add descrição...",
                  hintStyle: TextStyle(
                    color: Colors.blueGrey[600]!,
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                expands: true,
                minLines: null,
                maxLines: null,
                onChanged: (value) => widget.descriptionController.text = value,
                onFieldSubmitted: (value) =>
                    widget.descriptionController.text = value,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            width: MediaQuery.sizeOf(context).width,
            // color: Colors.purpleAccent,
            child: ListView.builder(
              itemCount: DummyData.commonDescriptions.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => DescriptionChip(
                  selectChip: _selectChip,
                  label: DummyData.commonDescriptions[index]),
            ),
          ),
        ],
      ),
    );
  }
}
