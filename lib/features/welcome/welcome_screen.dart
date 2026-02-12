import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

import 'package:tasky/screens/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture.withoutColorFilter(
                    path: 'assets/images/logo.svg',
                    width: 42,
                    height: 42,
                  ),

                  SizedBox(width: 16),
                  Text(
                    'Tasky',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: 118),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To Tasky',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(width: 8),
                  CustomSvgPicture.withoutColorFilter(
                    path: 'assets/images/waving_hand.svg',
                    width: 42,
                    height: 42,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Your productivity journey starts here.',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: 16),
              ),
              SizedBox(height: 24),

              CustomSvgPicture.withoutColorFilter(
                path: 'assets/images/welcome.svg',
                width: 215,
                height: 200,
              ),
              SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    title: 'Full Name',
                    hintText: 'Enter your full name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await PreferencesManager().setString(
                      'userName',
                      _nameController.value.text.trim(),
                    );

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter Your Full Name")),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width - 32, 40),
                ),
                child: Text('Let’s Get Started'),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
