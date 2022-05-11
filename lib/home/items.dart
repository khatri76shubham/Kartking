import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/itemsview.dart';

class items extends StatelessWidget {
  final int index;

  const items({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("store")
            .doc("Gajanand Bhandar")
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
                    builder: (context) =>
                        itemsview(image: snapshot.data?.docs[index])));
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
