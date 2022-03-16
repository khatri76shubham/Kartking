import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:kartking/pages/profile_page.dart';
import 'package:kartking/home/items.dart';
import 'package:kartking/pages/store_overview/storeview.dart';
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

  Widget stores(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      child: ListView.builder(
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            return itemBuilder(size, index, context);
          }),
    );
  }

  Widget itemBuilder(Size size, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => storeview()));
        },
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: size.height / 2.5,
            width: size.width / 1.1,
            child: Column(
              children: [
                Container(
                  height: size.height / 4,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(restaurantList[index].imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: size.height / 12,
                  width: size.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurantList[index].title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: size.height / 25,
                        width: size.width / 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          restaurantList[index].rating,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width / 1.2,
                  child: Text(
                    "${restaurantList[index].locations}   \t\t\t\t\t\t\t\t\t\t\t\t\t\t  ${restaurantList[index].price} for one",
                    style: TextStyle(
                      fontSize: 12.9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        backgroundColor: Color(0xff7E89F0),
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
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(18)),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [items(), items()],
                  ),
                  Column(
                    children: [items(), items()],
                  ),
                  Column(
                    children: [items(), items()],
                  ),
                  Column(
                    children: [items(), items()],
                  ),
                  Column(
                    children: [items(), items()],
                  ),
                ],
              ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      })
                ],
              ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  singlestore(
                      storeimage:
                          'https://media.istockphoto.com/photos/all-your-necessities-stored-in-one-place-picture-id1157106624?k=20&m=1157106624&s=612x612&w=0&h=jLXRK4qRL_3QITpschx1Wy2Aj2Vyy47Q1Q_R7hVcPQg=',
                      storename: 'kirana',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                  singlestore(
                      storeimage:
                          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-122620,resizemode-1,msid-75214721/industry/services/retail/future-group-negotiates-rents-for-its-1700-stores.jpg',
                      storename: 'store',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => storeview()));
                      }),
                ],
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
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
