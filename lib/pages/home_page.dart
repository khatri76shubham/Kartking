import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kartking/pages/profile_page.dart';

// ignore: camel_case_types
class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

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
          const Expanded(
            flex: 2,
            child: Text('h'),
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
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const profilepage()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xffE6E6E6),
                radius: 20,
                child: Icon(
                  Icons.person,
                  color: Color(0xffCCCCCC),
                ),
              ),
            ),
          ),
        ],
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
    );
  }
}
