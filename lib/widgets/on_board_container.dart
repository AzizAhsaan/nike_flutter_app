import 'package:flutter/material.dart';

class OnBoardContainer extends StatelessWidget {
  final List<Widget> children;
  const OnBoardContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xFF1483C2),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
