import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/checkout_page.dart';
import 'package:kartking/constant/colors.dart';

// ignore: camel_case_types
class cartpage extends StatefulWidget {
  cartpage({Key? key}) : super(key: key);

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("cartdata")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("yourcartdata")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primarycolor,
              title: Text('Your cart'),
            ),
            body: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: textcolor, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data?.docs[index]['storeid'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  child: Icon(
                                    Icons.delete,
                                    color: textcolor,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: textcolor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('items'), Text('price')],
                            ),
                            Divider(),
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("cartdata")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("yourcartdata")
                                    .doc(snapshot.data?.docs[index]['storeid'])
                                    .collection("storedata")
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
                                      itemCount:
                                          snapshot.data?.docs.length ?? 0,
                                      itemBuilder: ((context, index) {
                                        return Container(
                                          padding: EdgeInsets.all(3),
                                          margin: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: textcolor, width: .5),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: 55,
                                                      child: Image.network(
                                                          snapshot.data
                                                                  ?.docs[index]
                                                              ['cartimage'])),
                                                  Text(
                                                      snapshot.data?.docs[index]
                                                          ['cartname'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['cartprice'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        );
                                      }));
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8),
                                  height: 50,
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      checkout(
                                                        index: snapshot
                                                            .data?.docs[index],
                                                      )));
                                        },
                                        child: Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Text('total')
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: primarycolor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      border: Border.all(
                                          color: textcolor, width: 1.5)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          );
        });
  }
}
