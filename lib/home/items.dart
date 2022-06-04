import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/pages/product_overview/product_view.dart';

class items extends StatelessWidget {
  final int index;

  final storename;

  items({Key? key, required this.index, required this.storename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = storename['sname'];
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("store")
            .doc(name)
            .collection("items")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => productview(
                          itemnu: snapshot.data?.docs[index],
                          sid: storename,
                        )));
              },
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                snapshot.data?.docs[index]["iimage"]))),
                  ),
                  Expanded(child: Text(snapshot.data?.docs[index]["iname"])),
                ],
              ),
            ),
          );
        });
  }
}
