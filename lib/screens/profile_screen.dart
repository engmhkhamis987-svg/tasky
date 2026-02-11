import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  bool isLoading = false;

  Future<void> _loadUserName() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      userName = PreferencesManager().getString('userName') ?? '';
      motivationQuote =
          PreferencesManager().getString('motivation_quote') ?? '';
      isDarkMode = PreferencesManager().getBool("theme") ?? true;
      isLoading = false;
    });
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
                            backgroundImage: AssetImage(
                              'assets/images/person.png',
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () {},
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
}
