import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.maxLines,
  });
  final TextEditingController controller;
  final String title;
  final int? maxLines;
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
            hintText: 'Finish UI design for login screen',
            hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
          ),
          style: TextStyle(color: Color(0XFFFFFCFC)),
          validator: (value) {
            if (value!.trim() == "" || value.trim().isEmpty) {
              return 'Please enter task name';
            }
            return null;
          },
        ),
      ],
    );
  }
}
