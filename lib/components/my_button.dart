import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget text;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue[600], borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Center(child: text),
        ),
      ),
    );
  }
}
