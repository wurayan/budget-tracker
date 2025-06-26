import 'dart:ui';
import 'package:budget_tracker/view/widgets/collapsed_bottom_sheet.dart';
import 'package:budget_tracker/view/widgets/expanded_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BottomDraggableSheet extends StatefulWidget {
  const BottomDraggableSheet({super.key});

  @override
  State<BottomDraggableSheet> createState() => _BottomDraggableSheetState();
}

class _BottomDraggableSheetState extends State<BottomDraggableSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _currentHeight = 100;
  final double _expandedHeight = 500;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    // _currentHeight = MediaQuery.of(context).size.height * 0.1;
    // _expandedHeight = MediaQuery.of(context).size.height * 0.5;
    final double initialHeight = MediaQuery.of(context).size.height * 0.05;
    return BottomSheet(
      enableDrag: true,
      animationController: _controller,
      onClosing: () => _formKey.currentState?.reset(),
      builder: (context) => GestureDetector(
        onTap: () {
          _controller.animateTo(1.0);
          _currentHeight = _expandedHeight;
        },
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
            _currentHeight = initialHeight;
          } else {
            // Snap to nearest position
            if (_controller.value > 0.5) {
              _controller.animateTo(1.0);
              _currentHeight = _expandedHeight;
            } else {
              _controller.animateTo(0.0);
              _currentHeight = initialHeight;
            }
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: lerpDouble(
                initialHeight,
                _expandedHeight,
                _controller.value,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: _controller.value < 0.1
                  ? const CollapsedBottomSheet()
                  : ExpandedBottomSheet(
                      formKey: _formKey,
                      collapseForm: () {
                        _controller.animateTo(0.0);
                        _currentHeight = initialHeight;
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}
