import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userprovider with ChangeNotifier {
  static void adduserdata(
      {User? currentuser,
      String? UserName,
      String? UserEmail,
      String? UserMobileno,
      String? UserImage}) async {
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(currentuser!.uid)
        .set(
      {
        "UserId": currentuser.uid,
        "UserName": UserName,
        "UserEmail": UserEmail,
        "UserMobileno": UserMobileno,
        "UserImage": UserImage
      },
    );
  }
}
