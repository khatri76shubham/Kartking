import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourCartProvider with ChangeNotifier {
  void yourcartdata({
    String? storeid,
    String? storeimage,
  }) async {
    await FirebaseFirestore.instance
        .collection("cartdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourcartdata")
        .doc(storeid)
        .set(
      {"storeid": storeid, "storeimage": storeimage},
    );
  }
}

class CartProvider with ChangeNotifier {
  void addcartData({
    String? cartname,
    String? cartimage,
    String? cartid,
    String? cartprice,
    String? cartquantity,
    String? storeid,
  }) async {
    await FirebaseFirestore.instance
        .collection("cartdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourcartdata")
        .doc(storeid)
        .collection("storedata")
        .doc(cartid)
        .set(
      {
        "storeid": storeid,
        "cartname": cartname,
        "cartid": cartid,
        "cartimage": cartimage,
        "cartprice": cartprice,
        "cartquantity": cartquantity
      },
    );
  }
}
