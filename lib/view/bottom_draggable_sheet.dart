import 'dart:ui';

import 'package:flutter/material.dart';

class BottomDraggableSheet extends StatefulWidget {
  const BottomDraggableSheet({super.key});

  @override
  State<BottomDraggableSheet> createState() => _BottomDraggableSheetState();
}

class _BottomDraggableSheetState extends State<BottomDraggableSheet>
    with SingleTickerProviderStateMixin {
  // final _controller = PersistentBottomSheetController();
  // Controls sheet state
  // bool _isExpanded = false;
  // updateExpanded() => setState(() => _isExpanded = !_isExpanded);

  late AnimationController _controller;
  double _currentHeight = 100; // Initial collapsed height
  final double _expandedHeight = 400;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: true,
        animationController: _controller,
        onClosing: () {},
        builder: (context) => GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  _currentHeight = (_currentHeight - details.primaryDelta!)
                      .clamp(100, _expandedHeight);
                  _controller.value =
                      (_currentHeight - 100) / (_expandedHeight - 100);
                });
              },
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! < -500) {
                  // Swipe up fast
                  _controller.animateTo(1.0);
                  _currentHeight = _expandedHeight;
                } else if (details.primaryVelocity! > 500) {
                  // Swipe down fast
                  _controller.animateTo(0.0);
                  _currentHeight = 100;
                } else {
                  // Snap to nearest position
                  if (_controller.value > 0.5) {
                    _controller.animateTo(1.0);
                    _currentHeight = _expandedHeight;
                  } else {
                    _controller.animateTo(0.0);
                    _currentHeight = 100;
                  }
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    height: lerpDouble(100, _expandedHeight, _controller.value),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                    ),
                    child: _controller.value > 0.5
                        ? _buildExpandedForm()
                        : _buildCollapsedHandle(),
                  );
                },
              ),
            ));
  }

  Widget _buildExpandedForm() => Container(
        height: 500,
        color: Colors.teal,
      );
  Widget _buildCollapsedHandle() =>
      const Center(child: Icon(Icons.keyboard_arrow_up));
}
