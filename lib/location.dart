import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/add_delivery_address.dart';
import 'package:kartking/address_model.dart';
import 'package:kartking/address_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/single_address.dart';
import 'package:provider/provider.dart';

class location extends StatefulWidget {
  location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My address'),
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Adddeliveryaddress()));
                },
                child: Text(
                  "+ Add Address",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                )),
            Divider(
              color: textcolor,
            ),
            Text('Saved Address'),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text("Deliver To"),
            ),
            Divider(
              height: 1,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Address")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("moredata")
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
                        return SingleDeliveryItem(
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
                        );
                        ;
                      }));
                })
          ],
        ),
      ),
    );
  }
}
