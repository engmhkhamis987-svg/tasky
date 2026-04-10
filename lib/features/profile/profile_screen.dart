import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = true;
  late String userName;
  late String motivationQuote;
  String? userImagePath;
  bool isLoading = false;

  Future<void> _loadUserName() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      userName = PreferencesManager().getString('userName') ?? '';
      motivationQuote =
          PreferencesManager().getString('motivation_quote') ?? '';
      userImagePath = PreferencesManager().getString('user_image');
      isDarkMode = PreferencesManager().getBool("theme") ?? true;
      isLoading = false;
    });
  }

  Future<void> _pickProfileImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final newFile = await File(
        image.path,
      ).copy('${appDir.path}/${image.name}');

      PreferencesManager().setString("user_image", newFile.path);
      setState(() {
        userImagePath = image.path;
      });
    }
  }

  // void _saveImage(XFile file) async {
  //   final appDir = await getApplicationCacheDirectory();
  //   final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
  //   PreferencesManager().setString("user_image", newFile.path);
  // }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSizes.w16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw16),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _pickProfileImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.pw16),
                  Text("Gallary"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator(color: Color(0xffFFFCFC)))
        : Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppSizes.ph6),
                  child: Text(
                    'Profile Screen',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: AppSizes.ph16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60, //AppSizes.r60
                            backgroundImage: userImagePath == null
                                ? AssetImage('assets/images/person.png')
                                : FileImage(File(userImagePath!)),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () => _showImageSourceDialoge(context),

                            //_showImagePickerOptions,
                            child: Container(
                              width: AppSizes.w45,
                              height: AppSizes.w45,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.r100,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: AppSizes.r26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.ph8),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: AppSizes.ph4),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.ph24),
                Text(
                  'Profile info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          userName: userName,
                          motivationQuote: motivationQuote,
                        ),
                      ),
                    );

                    if (result != null && result) {
                      _loadUserName();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/profile_icon.svg',
                  ),
                  title: Text(
                    'user details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: CustomSvgPicture(
                    path: 'assets/images/arrow_right_icon.svg',
                  ),
                ),

                Divider(),

                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/dark_icon.svg',
                  ),

                  title: Text('Dark Mode'),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, value, child) {
                      return Switch(
                        value: value == ThemeMode.dark,
                        onChanged: (value) async {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    PreferencesManager().remove('userName');
                    PreferencesManager().remove('motivation_quote');
                    PreferencesManager().remove('tasks');
                    PreferencesManager().remove('theme');

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/log_out_icon.svg',
                  ),
                  title: Text('Log Out'),
                  trailing: CustomSvgPicture(
                    path: 'assets/images/arrow_right_icon.svg',
                  ),
                ),
              ],
            ),
          );
  }

  void _showButtomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
        minHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      showDragHandle: true,
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              color: Colors.red,
            );
          },
        );
      },
    );
  }
}
