import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  late final String userName;
  bool isLoading = false;

  Future<void> _loadUserName() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
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
                    style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
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
                                color: Color(0xff282828),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Color(0xffFFFCFC),
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFFFFCFC),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'One task at a time. One step closer.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Profile info',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFFFFFCFC),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/profile_icon.svg'),
                  title: Text(
                    'user details',
                    style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
                  ),
                  trailing: SvgPicture.asset(
                    'assets/images/arrow_right_icon.svg',
                  ),
                ),
                Divider(color: Color(0XFFCAC4D0)),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/dark_icon.svg'),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
                  ),
                  trailing: Switch(
                    // activeThumbColor: Color(0XFFFFFCFC),
                    // activeTrackColor: Color(0XFF15B86C),
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                ),
                Divider(color: Color(0XFFCAC4D0)),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SvgPicture.asset('assets/images/log_out_icon.svg'),
                  title: Text(
                    'Log Out',
                    style: TextStyle(color: Color(0XFFFFFCFC), fontSize: 16),
                  ),
                  trailing: SvgPicture.asset(
                    'assets/images/arrow_right_icon.svg',
                  ),
                ),
              ],
            ),
          );
  }
}
