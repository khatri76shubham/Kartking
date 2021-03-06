import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/home_page.dart';
import 'package:kartking/pages/cart_page.dart';
import 'package:kartking/pages/search_page.dart';
import 'package:kartking/pages/setting_page.dart';

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
    const Homepage(),
    const Searchpage(),
    const Cartpage(),
    const Settingpage(),
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
            Icon(Icons.shopping_cart),
            Icon(Icons.settings)
          ],
        ),
      ),
    );
  }
}
