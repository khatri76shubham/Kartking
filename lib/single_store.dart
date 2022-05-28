import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class Singlestore extends StatelessWidget {
  final int index;
  const Singlestore({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("store").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Material(
            elevation: 8,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => storeview(
                          Index: snapshot.data?.docs[index],
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 500 / 4,
                      width: 300 / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                                snapshot.data?.docs[index]["simage"]),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 500 / 7,
                      width: 300 / 1.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data?.docs[index]["sname"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 500 / 25,
                                width: 300 / 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data?.docs[index]["srating"],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              RatingBarIndicator(
                                rating: double.parse(
                                    snapshot.data?.docs[index]["srating"]),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
