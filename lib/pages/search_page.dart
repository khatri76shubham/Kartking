import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class searchpage extends StatefulWidget {
  searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("store").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final sidindex = snapshot.data?.docs;
            return ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: productsearch());
                  },
                  child: Container(
                    width: 400,
                    height: 55,
                    child: Center(child: Text("search here")),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'stores',
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
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => storeview(
                                      Index: snapshot.data?.docs[index])));
                            },
                            child: Container(
                              width: 30,
                              height: 50,
                              child: Center(
                                  child: Text(
                                snapshot.data?.docs[index]['sname'],
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: whitecolor,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data?.docs[index]['simage']),
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.7),
                                        BlendMode.dstIn),
                                  ),
                                  border:
                                      Border.all(color: primarycolor, width: 3),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ));
                    })),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("store")
                              .doc(sidindex?[index]['sname'])
                              .collection("items")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => productview(
                                          sid: sidindex?[index],
                                          itemnu: snapshot.data?.docs[index])));
                                },
                                child: Container(
                                  width: 30,
                                  height: 50,
                                  child: Center(
                                      child: Text(
                                    snapshot.data?.docs[index]['iname'],
                                    style: TextStyle(
                                        color: textcolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data?.docs[index]['iimage']),
                                        fit: BoxFit.cover,
                                        colorFilter: new ColorFilter.mode(
                                            Colors.black.withOpacity(0.7),
                                            BlendMode.dstIn),
                                      ),
                                      color: whitecolor,
                                      border: Border.all(
                                          color: primarycolor, width: 3),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            );
                          });
                    }))
              ],
            );
          }),
    );
  }
}

final stores = [
  'Bajrang Departmental Store',
  'Bharat Audio Center',
  'Gajanand Bhandar',
  'Khandelwal general store',
  'Khunteta Mobile',
  'Shree Govind Kirana Store',
  'Shree Hari The Grocery Point',
  'Singhal Kirana Store',
  'Vikas Mobile Shop',
];

class productsearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    var index = 0;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("store")
            .doc('${stores[index]}')
            .collection("items")
            .snapshots()
            .asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['iname']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              index++ < 9;

              return Center(
                  child: Text(
                "No Search Query Found",
                style: TextStyle(fontSize: 25),
              ));
            }
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['iname']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => productview(
                                itemnu: data,
                                sid: index,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            color: whitecolor,
                            border: Border.all(color: primarycolor, width: 2),
                          ),
                          height: 400 / 2.5,
                          width: 500 / 1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 400 / 2.5,
                                width: 500 / 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(data['iimage']),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(
                                height: 400 / 2.5,
                                width: 500 / 2.5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data['iname'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'price ->',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          data['iprice'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text('search for store'),
    );
  }
}
