import 'package:budget_tracker/view/bottom_draggable_sheet.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("appbar"),
        ),
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.blue[100],
        body: Column(
          children: [
            Container(
              color: Colors.brown,
              height: 200,
            )
          ],
        ),
        bottomSheet: const BottomDraggableSheet());
  }
}
