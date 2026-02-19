import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FormStyles {
  static InputDecoration buildInputDecoration(BuildContext context, {String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static DropdownStyleData buildDropdownStyleData(BuildContext context) {
    return DropdownStyleData(
      maxHeight: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      elevation: 4,
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(40),
        thickness: WidgetStateProperty.all(6),
        thumbVisibility: WidgetStateProperty.all(true),
      ),
    );
  }

  static MenuItemStyleData buildMenuItemStyleData(BuildContext context) {
    return MenuItemStyleData(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      selectedMenuItemBuilder: (context, child) {
        return Container(
          color: const Color(0xFFE0E5EA), // Light grey highlight from screenshot
          child: child,
        );
      },
    );
  }
}
