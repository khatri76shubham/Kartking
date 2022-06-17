import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/my_account.dart';
import 'package:kartking/pages/screens/profile_menu.dart';
import 'package:kartking/constant/theme.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Settingpage extends StatefulWidget {
  const Settingpage({Key? key}) : super(key: key);

  @override
  State<Settingpage> createState() => _SettingpageState();
}

// ignore: camel_case_types
class _SettingpageState extends State<Settingpage> {
  void launchwhatsapp({required message, required number}) async {
    final Uri url = Uri.parse("whatsapp://send/?phone=$number&text=$message");

    await canLaunchUrl(url)
        ? launchUrl(url)
        : Fluttertoast.showToast(msg: 'Can\'t open whatsapp ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: primarycolor,
      ),
      body: ListView(children: [
        Column(
          children: [
            ProfileMenu(
              text: 'My Account',
              icon: Icons.person_add_alt_1_outlined,
              press: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Myaccount()));
              },
            ),
            ProfileMenu(
              text: 'Theme',
              icon: Icons.change_circle,
              press: () {
                currentTheme.toggleTheme();
              },
            ),
            ProfileMenu(
              text: 'Help',
              icon: Icons.help,
              press: () {
                launchwhatsapp(message: "Hello", number: "+919602526622");
              },
            ),
            ProfileMenu(
              text: 'Call with Support',
              icon: Icons.phone_android,
              press: () {
                call();
              },
            ),
          ],
        ),
      ]),
    );
  }

  call() async {
    final Uri tel = Uri.parse("tel://+919351171925");
    try {
      await launchUrl(tel);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
