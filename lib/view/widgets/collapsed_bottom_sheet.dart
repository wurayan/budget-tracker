import 'package:flutter/material.dart';

class CollapsedBottomSheet extends StatelessWidget {
  const CollapsedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: const Text(
            "HOJE",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const Icon(Icons.keyboard_arrow_up)
      ],
    );
  }
}
