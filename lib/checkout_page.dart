import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/location.dart';
import 'package:kartking/pages/store_overview/storeview.dart';
import 'package:kartking/single_address.dart';

class Checkout extends StatefulWidget {
  final Index;

  Checkout({Key? key, this.Index}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? addressindex;
  @override
  Widget build(BuildContext context) {
    var storeid = widget.Index['storeid'];
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 150,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: whitecolor,
                  boxShadow: [
                    BoxShadow(
                      color: primarycolor,
                      offset: Offset(1.0, 3.0), //(x,y)
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deliverable address :-',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text('Home'),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _deliverableaddress(context);
                          },
                          child: Text('change address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: textcolor,
              ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('hello'),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primarycolor,
                        boxShadow: [
                          BoxShadow(
                            color: textcolor,
                            offset: Offset(1.0, 3.0), //(x,y)
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("cartdata")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("yourcartdata")
              .doc('$storeid')
              .collection('storedata')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var tPrice = 0;
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your order",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                        Text(
                          'From',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w400),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.Index['storeid'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 5),
                                Container(
                                  height: 100,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.Index['storeimage']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Text('items'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                              Text('Qty'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('prices'),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                      ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length ?? 0,
                        itemBuilder: ((context, index) {
                          if (snapshot.data!.docs.length > index) {
                            tPrice = tPrice +
                                int.parse(totalPrice(
                                    snapshot.data!.docs[index]['cartquantity'],
                                    snapshot.data!.docs[index]['cartprice']));
                          } else {
                            tPrice = 0;
                          }
                          var discountprice = tPrice - 50;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                const Divider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            height: 35,
                                            width: 50,
                                            child: Image(
                                              image: NetworkImage(snapshot.data
                                                  ?.docs[index]['cartimage']),
                                              fit: BoxFit.cover,
                                            )),
                                        Container(
                                            width: 100,
                                            height: 20,
                                            child: Text(snapshot.data
                                                ?.docs[index]['cartname'])),
                                      ],
                                    ),
                                    Text(snapshot.data?.docs[index]
                                        ['cartquantity']),
                                    Container(
                                        width: 40,
                                        height: 20,
                                        child: Text(
                                          totalPrice(
                                              snapshot.data?.docs[index]
                                                  ['cartquantity'],
                                              snapshot.data?.docs[index]
                                                  ['cartprice']),
                                        )),
                                  ],
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      if (snapshot.data?.docs.length ==
                                          index + 1) ...[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Item total',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '$tPrice',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Discount',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '-50',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Grand total',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                              Text(
                                                '$discountprice',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("store")
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
                            itemCount: snapshot.data?.docs.length ?? 0,
                            itemBuilder: ((context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: snapshot.data?.docs[index]['sname'] ==
                                          storeid
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        storeview(
                                                          Index: snapshot.data!
                                                              .docs[index],
                                                        )));
                                          },
                                          child: const Text(
                                            '+ Add items',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red),
                                          ),
                                        )
                                      : Container(
                                          color: textcolor,
                                          height: 0,
                                        ));
                            }));
                      }),
                  Divider(),
                ],
              ),
            );
          }),
    );
  }
}

void _deliverableaddress(context, final addressindex) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Address")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("moredata")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Row(
                    children: [
                      Text('No data Please add address'),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => location()));
                        },
                        child: Text('Click here'),
                      )
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Text("Select deliverable address"),
                  ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => bottomBar(
                            //           addressindex: snapshot.data?.docs[index],
                            //         )));
                            var addressindex = snapshot.data?.docs[index];
                          },
                          child: SingleDeliveryItem(
                            address: snapshot.data?.docs[index]['area'] +
                                ', ' +
                                snapshot.data?.docs[index]['street'] +
                                ', ' +
                                snapshot.data?.docs[index]['landmark'] +
                                ', ' +
                                snapshot.data?.docs[index]['pincode'],
                            title: snapshot.data?.docs[index]['name'],
                            number: snapshot.data?.docs[index]['mobileno'],
                            addressType: snapshot.data?.docs[index]
                                        ['addresstype'] ==
                                    "Addresstype.Home"
                                ? "Home"
                                : snapshot.data?.docs[index]['addresstype'] ==
                                        "Addresstypes.Other"
                                    ? "Other"
                                    : "Work",
                          ),
                        );
                      })),
                ],
              );
            });
      });
}

// class bottomBar extends StatefulWidget {
//   final addressindex;
//   bottomBar({Key? key, this.addressindex}) : super(key: key);

//   @override
//   State<bottomBar> createState() => _bottomBarState();
// }

// class _bottomBarState extends State<bottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     print('${widget.addressindex}');
//     return 
//     // });
//   }
// }
