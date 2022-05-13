import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Datacontroller extends GetxController {
  Future getdata(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future querydata(String querystring) async {
    return FirebaseFirestore.instance
        .collection('store')
        .where('sname', isGreaterThanOrEqualTo: querystring)
        .get();
  }
}
