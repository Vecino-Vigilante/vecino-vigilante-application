import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration getDecoration({
    IconData? suffixIcon,
    String? helperText,
    String? hintText,
    required String labelText,
    required ThemeData theme,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.primaryColor,
        ),
      ),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      helperText: helperText,
      hintText: hintText,
      labelText: labelText,
      suffixIcon: suffixIcon != null
          ? const Icon(Icons.keyboard_arrow_down_rounded)
          : null,
    );
  }
}
