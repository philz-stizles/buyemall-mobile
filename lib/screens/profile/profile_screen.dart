import 'package:flutter/material.dart';
import 'package:mobile/enums.dart';
import 'package:mobile/screens/profile/widgets/profile_menu.dart';
import 'package:mobile/screens/profile/widgets/profile_pic.dart';
import 'package:mobile/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  static String routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: 'My Account',
            icon: 'assets/icons/User.svg',
            onPress: () => {},
          ),
          ProfileMenu(
            text: 'Notifications',
            icon: 'assets/icons/Bell.svg',
            onPress: () {},
          ),
          ProfileMenu(
            text: 'Settings',
            icon: 'assets/icons/Settings.svg',
            onPress: () {},
          ),
          ProfileMenu(
            text: 'Help Center',
            icon: 'assets/icons/QuestionMark.svg',
            onPress: () {},
          ),
          ProfileMenu(
            text: 'Log Out',
            icon: 'assets/icons/Logout.svg',
            onPress: () {},
          ),
        ],
      ),
    ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}