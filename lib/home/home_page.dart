import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/store.dart';
import 'package:kartking/my_account.dart';
import 'package:kartking/home/items.dart';
import 'package:kartking/single_store.dart';

// ignore: camel_case_types
class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  Widget divider() {
    return const Divider(
      color: Colors.grey,
      height: 30,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: primarycolor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myaccount()),
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 150,
                    width: 360,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(18)),
                  ),
                ),
              ],
            ),
            divider(),
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
            SizedBox(
              height: 250,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: demo_products.length,
                  itemBuilder: (context, index) => items(
                        index: index,
                      )),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Near you',
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
            SizedBox(
              height: 200,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: demo_products.length - 1,
                  itemBuilder: (context, index) => singlestore(index: index)),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'favorite store',
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
            SizedBox(
              height: 200,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: demo_products.length - 1,
                  itemBuilder: (context, index) => singlestore(index: index)),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Stores',
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
            stores(size),
          ],
        ),
      ),
    );
  }
}
