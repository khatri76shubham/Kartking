import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: camel_case_types
class navbar extends StatefulWidget {
  const navbar({Key? key}) : super(key: key);

  @override
  _navbarState createState() => _navbarState();
}

// ignore: camel_case_types
class _navbarState extends State<navbar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      showUnselectedLabels: false,
      onTap: (index) => setState(() => currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'cart'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
      ],
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class homescreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  homescreen({Key? key}) : super(key: key);

  Widget items() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 230,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff8F99F6),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(''),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'rice',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: const Color(0xff7E89F0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                      color: const Color(0xff8F99F6),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 30,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Items',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  items(),
                  items(),
                  items(),
                  items(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Fav',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  items(),
                  items(),
                  items(),
                  items(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const navbar(),
    );
  }
}
