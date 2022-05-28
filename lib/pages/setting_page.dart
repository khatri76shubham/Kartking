import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/login.dart';
import 'package:kartking/my_account.dart';
import 'package:kartking/pages/screens/profile_menu.dart';
import 'package:kartking/theme.dart';
import 'package:kartking/user_provider.dart';
import 'package:provider/provider.dart';

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
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => myaccount()));
              },
            ),
            ProfileMenu(
              text: 'Theme',
              icon: ("assets/icons/theme.svg"),
              press: () {
                currentTheme.toggleTheme();
              },
            ),
            ProfileMenu(
              text: 'Help',
              icon: ("assets/icons/Question mark.svg"),
              press: () {},
            ),
            ProfileMenu(
              text: 'Notification',
              icon: ("assets/icons/Bell.svg"),
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
