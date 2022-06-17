import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

//use when someone add store to favorite
class Favoritestore extends StatelessWidget {
  final int index;
  const Favoritestore({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        //Stream builder to collect data from favoritedata
        stream: FirebaseFirestore.instance
            .collection("favoritedata")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("favoritestore")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //circular indicator when data available
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Material(
            elevation: 8,
            child: GestureDetector(
              //onclick move to store view page
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Storeview(
                          Index: snapshot.data?.docs[
                              index], //Index pass value to store view page
                        )));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height /
                          6.1, //image container height
                      width: MediaQuery.of(context).size.width /
                          1.8, //image container width
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
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width / 1,
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
                                height: MediaQuery.of(context).size.height / 30,
                                width: MediaQuery.of(context).size.height / 20,
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
