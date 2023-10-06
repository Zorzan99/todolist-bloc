// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TodoListFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TodoListFormField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.icon,
    this.onPressed,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
