import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartking/address_model.dart';
import 'package:kartking/location.dart';
import 'package:location/location.dart';

class addressprovider with ChangeNotifier {
  bool isloading = false;
  TextEditingController name = TextEditingController();
  TextEditingController mobileno = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData? setlocation;

  void vaildator(context, mytype) async {
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
    } else if (setlocation == null) {
      Fluttertoast.showToast(msg: 'set location is empty');
    } else {
      isloading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("Address")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "name": name.text,
        "mobile no.": mobileno.text,
        "area": area.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "state": state.text,
        "pincode": pincode.text,
        "addresstype": mytype.toString(),
        "longitute": setlocation!.longitude,
        "latitute": setlocation!.latitude,
      }).then((value) async {
        isloading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<addressmodel> addresslist = [];
  getaddressdata() async {
    List<addressmodel> newlist = [];
    addressmodel addressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("Address")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      addressModel = addressmodel(
        addressType: _db.get("addresstype"),
        area: _db.get("area"),
        city: _db.get("city"),
        landMark: _db.get("landmark"),
        mobileNo: _db.get("mobileno"),
        name: _db.get("name"),
        pinCode: _db.get("pincode"),
        state: _db.get("state"),
        street: _db.get("street"),
      );
      newlist.add(addressModel);
      notifyListeners();
    }
    addresslist = newlist;
    notifyListeners();
  }

  List<addressmodel> get getaddresslist {
    return addresslist;
  }
}
