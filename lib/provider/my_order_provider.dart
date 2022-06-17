import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyorderProvider with ChangeNotifier {
  void addorderData({
    String? paymentstatus,
    String? storeid,
    String? storeimage,
  }) async {
    await FirebaseFirestore.instance
        .collection("cartdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourcartdata")
        .doc(storeid)
        .set(
      {
        "paymentstatus": paymentstatus,
        "storeid": storeid,
        "storeimage": storeimage,
      },
    );
  }
}
