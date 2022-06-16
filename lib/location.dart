import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/add_delivery_address.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/single_address.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My address'),
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Adddeliveryaddress()));
                },
                child: const Text(
                  "+ Add Address",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                )),
            Divider(
              color: textcolor,
            ),
            const Text('Saved Address'),
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              title: Text("Deliver To"),
            ),
            const Divider(
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No data Please add address'),
                    );
                  }
                  return ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
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
                      }));
                })
          ],
        ),
      ),
    );
  }
}
