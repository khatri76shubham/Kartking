import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/chat_page.dart';
import 'package:kartking/home/home_page.dart';
import 'package:kartking/pages/search_page.dart';
import 'package:kartking/pages/setting_page.dart';
import 'package:kartking/pages/shop_page.dart';

// ignore: camel_case_types
class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

// ignore: camel_case_types
class _homescreenState extends State<homescreen> {
  int currentIndex = 0;

  // ignore: non_constant_identifier_names
  final Screen = [
    const homepage(),
    const searchpage(),
    const shoppage(),
    const chatpage(),
    const settingpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Screen[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: primarycolor,
          buttonBackgroundColor: textcolor,
          backgroundColor: Colors.transparent,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            Icon(Icons.home),
            Icon(Icons.search),
            Icon(Icons.shop),
            Icon(Icons.chat),
            Icon(Icons.settings)
          ],
        ),
      ),
    );
  }
}
