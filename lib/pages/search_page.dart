import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/items_view_all.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("store").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final sidindex = snapshot.data?.docs;
            return ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: Productsearch());
                  },
                  child: Container(
                    width: 400,
                    height: 55,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(child: Text("search here")),
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
                    ],
                  ),
                ),
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Storeview(
                                      Index: snapshot.data?.docs[index])));
                            },
                            child: Container(
                              width: 30,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: whitecolor,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data?.docs[index]['simage']),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.7),
                                        BlendMode.dstIn),
                                  ),
                                  border:
                                      Border.all(color: primarycolor, width: 3),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                snapshot.data?.docs[index]['sname'],
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ));
                    })),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Items',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Itemsviewall()));
                        },
                        child: const Text(
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
                    physics: const ScrollPhysics(),
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
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Productview(
                                          sid: sidindex?[index],
                                          itemnu: snapshot.data?.docs[index])));
                                },
                                child: Container(
                                  width: 30,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data?.docs[index]['iimage']),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.7),
                                            BlendMode.dstIn),
                                      ),
                                      color: whitecolor,
                                      border: Border.all(
                                          color: primarycolor, width: 3),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    snapshot.data?.docs[index]['iname'],
                                    style: TextStyle(
                                        color: textcolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
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

class Productsearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
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
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("store").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                var name = snapshot.data!.docs[index];
                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("store")
                        .doc(name['sname'])
                        .collection("items")
                        .snapshots()
                        .asBroadcastStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
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
                          return const SizedBox.shrink();
                        }
                        return Column(
                          children: [
                            Text(
                              name['sname'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            GridView(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 5.0,
                              ),
                              children: [
                                ...snapshot.data!.docs
                                    .where((QueryDocumentSnapshot<Object?>
                                            element) =>
                                        element['iname']
                                            .toString()
                                            .toLowerCase()
                                            .contains(query.toLowerCase()))
                                    .map((QueryDocumentSnapshot<Object?> data) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Productview(
                                                      sid: name,
                                                      itemnu: data,
                                                    )));
                                      },
                                      child: Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 3),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(18),
                                                  topRight: Radius.circular(18),
                                                ),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data['iimage']),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Text(data["iname"]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                            Divider(color: textcolor),
                          ],
                        );
                      }
                    });
              }));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('search for store'),
    );
  }
}
