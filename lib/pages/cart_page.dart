import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:kartking/checkout_page.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/login.dart';

// ignore: camel_case_types
class cartpage extends StatefulWidget {
  const cartpage({Key? key}) : super(key: key);

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("cartdata")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("yourcartdata")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primarycolor,
                title: const Text('Your cart'),
              ),
              body: Center(
                child: Text('No Data Is available in Your cart'),
              ),
            );
          }
          if (FirebaseAuth.instance.currentUser!.uid.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primarycolor,
                title: const Text('Your cart'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Watch your cart! please login'),
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: SignInButton(
                        Buttons.Google,
                        text: 'Sign in with Google',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const login(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primarycolor,
              title: const Text('Your cart'),
            ),
            body: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(8),
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
                                  child: IconButton(
                                    key: Key(
                                        snapshot.data?.docs[index]['storeid']),
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("cartdata")
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .collection("yourcartdata")
                                          .doc(snapshot.data?.docs[index]
                                              ['storeid'])
                                          .delete();
                                      FirebaseFirestore.instance
                                          .collection("cartdata")
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .collection("yourcartdata")
                                          .doc(snapshot.data?.docs[index]
                                              ['storeid'])
                                          .collection('storedata')
                                          .get()
                                          .then((QuerySnapshot querySnapshot) {
                                        querySnapshot.docs.forEach((doc) {
                                          doc.reference.delete();
                                        });
                                      });
                                    },
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
                                  var tPrice = 0;
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  return ListView.builder(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: ((context, index) {
                                        if (snapshot.data!.docs.length >
                                            index) {
                                          tPrice = tPrice +
                                              int.parse(totalPrice(
                                                  snapshot.data?.docs[index]
                                                      ['cartquantity'],
                                                  snapshot.data?.docs[index]
                                                      ['cartprice']));
                                        } else {
                                          tPrice = 0;
                                        }

                                        return Column(
                                          children: [
                                            Dismissible(
                                              key: Key(snapshot.data
                                                  ?.docs[index]['cartname']),
                                              onDismissed: (direction) {
                                                FirebaseFirestore.instance
                                                    .collection("cartdata")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection("yourcartdata")
                                                    .doc(snapshot
                                                            .data?.docs[index]
                                                        ['storeid'])
                                                    .collection("storedata")
                                                    .doc(snapshot.data
                                                        ?.docs[index]['cartid'])
                                                    .delete();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: textcolor,
                                                        width: .5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            height: 55,
                                                            child: Image.network(
                                                                snapshot.data
                                                                            ?.docs[
                                                                        index][
                                                                    'cartimage'])),
                                                        Text(
                                                            snapshot.data?.docs[
                                                                    index]
                                                                ['cartname'],
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                      ],
                                                    ),
                                                    Text('x' +
                                                        snapshot.data
                                                                ?.docs[index]
                                                            ['cartquantity']),
                                                    Text(
                                                      totalPrice(
                                                          snapshot.data
                                                                  ?.docs[index]
                                                              ['cartquantity'],
                                                          snapshot.data
                                                                  ?.docs[index]
                                                              ['cartprice']),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (snapshot.data?.docs.length ==
                                                index + 1) ...[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Checkout(
                                                                        Index: snapshot
                                                                            .data
                                                                            ?.docs[index],
                                                                      )));
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 8),
                                                      height: 50,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          color: primarycolor,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          25)),
                                                          border: Border.all(
                                                              color: textcolor,
                                                              width: 1.5)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            "Buy Now",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20),
                                                          ),
                                                          Text('$tPrice')
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]
                                          ],
                                        );
                                      }));
                                }),
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
