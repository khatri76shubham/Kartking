import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartking/store_model.dart';

class Storeprovider with ChangeNotifier {
  List<Storemodel> store = [];
  Storemodel? storemodel;
  fatchstore() async {
    List<Storemodel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("store").get();
    value.docs.forEach((element) {
      storemodel = Storemodel(
        sname: element.get("sname"),
        simage: element.get("simage"),
      );
      newList.add(storemodel!);
    });
    store = newList;
    notifyListeners();
  }

  List<Storemodel> get getstorelist {
    return store;
  }
}
