import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/constants/storage_key.dart';

import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/navigations/main_screen.dart';

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
              SizedBox(height: AppSizes.ph30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgPicture.withoutColorFilter(
                    path: 'assets/images/logo.svg',
                    width: AppSizes.w42,
                    height: AppSizes.h42,
                  ),

                  SizedBox(width: AppSizes.pw16),
                  Text(
                    'Tasky',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.ph100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To Tasky',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(width: AppSizes.pw8),
                  CustomSvgPicture.withoutColorFilter(
                    path: 'assets/images/waving_hand.svg',
                    width: AppSizes.w42,
                    height: AppSizes.h42,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.ph8),
              Text(
                'Your productivity journey starts here.',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(fontSize: AppSizes.sp16),
              ),
              SizedBox(height: AppSizes.ph24),

              CustomSvgPicture.withoutColorFilter(
                path: 'assets/images/welcome.svg',
                width: AppSizes.w200,
                height: AppSizes.h200,
              ),
              SizedBox(height: AppSizes.ph24),

              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.pw16),
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

              SizedBox(height: AppSizes.ph24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.ph16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await PreferencesManager().setString(
                        StorageKey.username,
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

                  child: Text('Let’s Get Started'),
                ),
              ),
              SizedBox(height: AppSizes.ph24),
            ],
          ),
        ),
      ),
    );
  }
}
