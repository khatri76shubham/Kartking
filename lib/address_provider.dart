import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addressprovider with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController setlocation = TextEditingController();
  Future<void> vaildator() async {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: 'please enter your name');
    } else if (mobileno.text.isEmpty) {
      Fluttertoast.showToast(msg: 'mobile number is empty');
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: 'area is empty');
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: 'street is empty');
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: 'landmark is empty');
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: 'city is empty');
    } else if (state.text.isEmpty) {
      Fluttertoast.showToast(msg: 'state is empty');
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: 'pincode is empty');
    } else if (setlocation.text.isEmpty) {
      Fluttertoast.showToast(msg: 'mobile number is empty');
    } else {
      // await FirebaseFirestore.instance
      //     .collection("Address")
      //     .doc(FirebaseAuth.instance)
      //     .set({});
    }
  }
}
