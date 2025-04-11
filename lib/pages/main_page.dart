import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:registration_app/pages/signup_page.dart';
import 'user_details_page.dart';
import '../model/user_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  UserData tempUser = UserData(
    fullName: "Unknown",
    phoneNumber: "Unknown",
    emailAddress: "Unknown",
    biography: "Unknown",
  );

  @override
  Widget build(BuildContext context) {
    final pages = [
      SignUpPage(onUserCreated: (user) {
        setState(() {
          tempUser = user;
          _selectedIndex = 1;
        });
      }),
      UserDetailsPage(userData: tempUser),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('main_title'.tr())),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.app_registration),
            label: 'sign_up'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: 'user_details'.tr(),
          ),
        ],
      ),
    );
  }
}
