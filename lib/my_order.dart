import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
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
            return const Center(
              child: Text("No Orders Found"),
            );
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: primarycolor,
                title: const Text('Your Orders'),
              ),
              body: ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: ((context, index) {
                    if (snapshot.data?.docs[index]['paymentstatus'] == "done") {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: textcolor, width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data?.docs[index]['storeid'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Divider(
                                color: textcolor,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [Text('items'), Text('price')],
                              ),
                              const Divider(),
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("cartdata")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("yourcartdata")
                                      .doc(
                                          snapshot.data?.docs[index]['storeid'])
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
                                        physics: const ScrollPhysics(),
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
                                              Container(
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
                                                    // ignore: prefer_interpolation_to_compose_strings
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
                                              if (snapshot.data?.docs.length ==
                                                  index + 1) ...[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 8),
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
                                                                color:
                                                                    textcolor,
                                                                width: 1.5)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
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
                      );
                    }
                    return const SizedBox.shrink();
                  })));
        });
  }
}
