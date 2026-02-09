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
        Text(
          title,
          style: TextStyle(
            color: Color(0xffFFFCFC),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: hintText),
          style: TextStyle(color: Color(0XFFFFFCFC)),
          validator: validator != null ? (value) => validator!(value!) : null,
        ),
      ],
    );
  }
}
