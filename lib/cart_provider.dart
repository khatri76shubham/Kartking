import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartProvider with ChangeNotifier {
  void addcartData({
    String? cartname,
    String? cartimage,
    String? cartid,
    String? cartprice,
    String? cartquantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("cartdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourcartdata")
        .doc(cartid)
        .set(
      {
        "cartname": cartname,
        "cartid": cartid,
        "cartimage": cartimage,
        "cartprice": cartprice,
        "cartquantity": cartquantity
      },
    );
  }

  // UserModel? currentdata;
  // void getuserdata() async {
  //   UserModel userModel;
  //   var value = await FirebaseFirestore.instance
  //       .collection("usersData")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   if (value.exists) {
  //     userModel = UserModel(
  //       userEmail: value.get("userEmail"),
  //       userImage: value.get("userImage"),
  //       userName: value.get("userName"),
  //       userUid: value.get("userUid"),
  //     );
  //     currentdata = userModel;
  //     notifyListeners();
  //   }
  // }

  // UserModel? get currentuserdata {
  //   return currentdata;
  // }
}
