import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  void addfavoriteData({
    String? sname,
    String? simage,
    String? srating,
    String? slocation,
  }) async {
    await FirebaseFirestore.instance
        .collection("favoritedata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favoritestore")
        .doc(sname)
        .set(
      {
        "sname": sname,
        "simage": simage,
        "slocation": slocation,
        "srating": srating,
      },
    );
  }
}
