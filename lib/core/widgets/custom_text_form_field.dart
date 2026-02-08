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
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0XFF282828),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
          ),
          style: TextStyle(color: Color(0XFFFFFCFC)),
          validator: validator != null ? (value) => validator!(value!) : null,
        ),
      ],
    );
  }
}
