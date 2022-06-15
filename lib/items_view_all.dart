import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/product_overview/product_view.dart';

class Itemsviewall extends StatefulWidget {
  Itemsviewall({Key? key}) : super(key: key);

  @override
  State<Itemsviewall> createState() => _ItemsviewallState();
}

class _ItemsviewallState extends State<Itemsviewall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('All items'),
          backgroundColor: primarycolor,
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
              return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: ((context, index) {
                    var name = snapshot.data!.docs[index];
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("store")
                            .doc(name['sname'])
                            .collection("items")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 5.0,
                              ),
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => productview(
                                                    sid: name,
                                                    itemnu: snapshot
                                                        .data?.docs[index],
                                                  )));
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                12,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                            .data?.docs[index]
                                                        ["iimage"]))),
                                          ),
                                          Expanded(
                                              child: Container(
                                            child: Text(snapshot
                                                .data?.docs[index]["iname"]),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                  }));
            }));
  }
}
