import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

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
        padding: EdgeInsets.all(16),
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
                  SizedBox(width: 15),
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
                  SizedBox(width: 15),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Profile Screen',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: userImagePath == null
                                ? AssetImage('assets/images/person.png')
                                : FileImage(File(userImagePath!)),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () => _showImageSourceDialoge(context),

                            //_showImagePickerOptions,
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(Icons.camera_alt_outlined, size: 26),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 4),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
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
