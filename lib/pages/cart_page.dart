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
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("yourcartdata")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: primarycolor,
                title: Text('Your cart'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Watch your cart! please login'),
                    SizedBox(
                      height: 50,
                      width: 350,
                      child: SignInButton(
                        Buttons.Google,
                        text: 'Sign in with Google',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => login(),
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
                                    return const Center(
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
                                          padding: const EdgeInsets.all(3),
                                          margin: const EdgeInsets.all(3),
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
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ],
                                              ),
                                              Text(
                                                snapshot.data?.docs[index]
                                                    ['cartprice'],
                                                style: const TextStyle(
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Checkout(
                                                Index: snapshot
                                                    .data?.docs[index])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: primarycolor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        border: Border.all(
                                            color: textcolor, width: 1.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text('total')
                                      ],
                                    ),
                                  ),
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
