import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/store.dart';
import 'package:kartking/my_account.dart';
import 'package:kartking/home/items.dart';
import 'package:kartking/single_store.dart';
import 'package:provider/provider.dart';

import '../pages/store_overview/storeview.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
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
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("store").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 5.0,
                          ),
                          itemCount: snapshot.data?.docs.length ?? 0,
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
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) =>
                              singlestore(index: index)),
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
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) =>
                              singlestore(index: index)),
                    ),
                    divider(),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Stores',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'view all',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: ScrollPhysics(),
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => storeview(
                                        Index: snapshot.data?.docs[index])));
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
                                              image: NetworkImage(snapshot
                                                  .data?.docs[index]["simage"]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        height: size.height / 12,
                                        width: size.width / 1.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data?.docs[index]
                                                  ["sname"],
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
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                snapshot.data?.docs[index]
                                                    ['srating'],
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
                                          "${snapshot.data?.docs[index]["slocation"]}   \t\t\t\t\t\t\t\t\t\t\t\t\t\t ",
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
                        })),
                  ],
                ),
              );
            }));
  }
}
