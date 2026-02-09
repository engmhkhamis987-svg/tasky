import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });
  final bool value;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool? val) => onChanged(val),
      activeColor: Color(0XFF15B86C),
    );
  }
}
