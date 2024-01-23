import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 70, 67, 67),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 100, 95, 95),
            ),
          ),
          fillColor: const Color.fromARGB(255, 51, 50, 50),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          )),
    );
  }
}
