import 'package:flutter/material.dart';

class EasyTextFormField extends StatelessWidget {
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final ValueChanged<String> onChanged;
  final Widget prefixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;

  const EasyTextFormField(
      {super.key,
      required this.keyboardType,
      required this.obscureText,
      required this.validator,
      required this.onSaved,
      required this.onChanged,
      required this.prefixIcon,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      key: super.key,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
