import 'package:flutter/material.dart';

class DescriptionChip extends StatelessWidget {
  final Function(String value) selectChip;
  final String label;
  const DescriptionChip(
      {super.key, required this.selectChip, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: () => selectChip(label),
        child: Chip(
          backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          visualDensity: VisualDensity(vertical: -3),
          side: BorderSide.none,
          label: Text(
            label,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
