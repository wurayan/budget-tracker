import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue[300],
            width: 200,
            height: 100,
          ),
          Container(
            color: Colors.pink[200],
            width: 200,
            height: 100,
          ),
          Container(
            color: Colors.white,
            width: 200,
            height: 100,
          ),
        ],
      ),
    );
  }
}
