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
      body: ListView(
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
                  color: primarycolor, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
                      color: Colors.blueGrey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("store").snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
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
                    }));
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
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
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("store")
                  .doc("Gajanand Bhandar")
                  .collection("items")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => productview(
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
                                  image: NetworkImage(
                                      snapshot.data?.docs[index]['iimage']),
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.7),
                                      BlendMode.dstIn),
                                ),
                                color: whitecolor,
                                border:
                                    Border.all(color: primarycolor, width: 3),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      );
                    }));
              })
        ],
      ),
    );
  }
}

class productsearch extends SearchDelegate {
  final CollectionReference _firebasefirestore =
      FirebaseFirestore.instance.collection("store");
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
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
    return StreamBuilder<QuerySnapshot>(
        stream: _firebasefirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['sname']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
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
                        element['sname']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => storeview(Index: data)));
                    },
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(18),
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            color: whitecolor,
                            border: Border.all(color: primarycolor, width: 2),
                          ),
                          height: 400 / 2.5,
                          width: 500 / 1.1,
                          child: Column(
                            children: [
                              Container(
                                height: 350 / 4,
                                width: 500 / 1.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage(data['simage']),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                height: 350 / 12,
                                width: 500 / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data['sname'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      height: 350 / 25,
                                      width: 500 / 7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        data['srating'],
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
                                width: 500 / 1.2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data['slocation']}",
                                      style: TextStyle(
                                        fontSize: 12.9,
                                        fontWeight: FontWeight.w500,
                                      ),
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
