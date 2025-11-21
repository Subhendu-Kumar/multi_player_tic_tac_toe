import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isReadOnly;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.isReadOnly,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: colorScheme.surface,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: colorScheme.primary.withValues(alpha: 0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      style: TextStyle(color: colorScheme.onSurface),
    );
  }
}
