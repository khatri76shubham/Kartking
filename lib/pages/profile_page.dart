import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/mainpage/login.dart';
import 'package:kartking/pages/screens/profile_menu.dart';
import 'package:kartking/pages/screens/profile_pic.dart';

// ignore: camel_case_types
class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

// ignore: camel_case_types
class _profilepageState extends State<profilepage> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xff7E89F0),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ProfilePic(),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: 'My Account',
            icon: 'assets/icons/User Icon.svg',
            press: () {},
          ),
          ProfileMenu(
            text: 'Notification',
            icon: ("assets/icons/Bill.svg"),
            press: () {},
          ),
          ProfileMenu(
            text: 'Help',
            icon: ("assets/icons/Question mark.svg"),
            press: () {},
          ),
          ProfileMenu(
            text: 'Log out',
            icon: ("assets/icons/Log out.svg"),
            press: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => login()));
            },
          ),
        ],
      ),
    );
  }
}
