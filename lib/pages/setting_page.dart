import 'package:flutter/material.dart';
import 'package:kartking/pages/screens/profile_menu.dart';

// ignore: camel_case_types
class settingpage extends StatefulWidget {
  const settingpage({Key? key}) : super(key: key);

  @override
  State<settingpage> createState() => _settingpageState();
}

// ignore: camel_case_types
class _settingpageState extends State<settingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Color(0xff7E89F0),
      ),
      body: ListView(children: [
        Column(
          children: [
            ProfileMenu(
              text: 'My Account',
              icon: ("assets/icons/User Icon.svg"),
              press: () {},
            ),
            ProfileMenu(
              text: 'Theme',
              icon: ("assets/icons/theme.svg"),
              press: () {},
            ),
            ProfileMenu(
              text: 'Privacy/Security',
              icon: ("assets/icons/Lock.svg"),
              press: () {},
            ),
            ProfileMenu(
              text: 'Two step verification',
              icon: ("assets/icons/shield.svg"),
              press: () {},
            ),
            ProfileMenu(
              text: 'App language',
              icon: ("assets/icons/language.svg"),
              press: () {},
            ),
          ],
        ),
      ]),
    );
  }
}
