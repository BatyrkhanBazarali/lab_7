import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../model/user_data.dart';

class UserDetailsPage extends StatelessWidget {
  final UserData userData;

  const UserDetailsPage({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('user_details_title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name: ${userData.fullName}", style: const TextStyle(fontSize: 18)),
            Text("Phone: ${userData.phoneNumber}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${userData.emailAddress}", style: const TextStyle(fontSize: 18)),
            Text("Biography: ${userData.biography}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
