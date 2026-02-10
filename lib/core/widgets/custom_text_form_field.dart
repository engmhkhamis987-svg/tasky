import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.maxLines,
    this.validator,
    required this.hintText,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final int? maxLines;
  final Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: hintText),
          style: Theme.of(context).textTheme.labelMedium,
          validator: validator != null ? (value) => validator!(value!) : null,
        ),
      ],
    );
  }
}
