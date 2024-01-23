import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const CustomGestureDetector({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 139, 126, 126),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
