import 'package:flutter/material.dart';

Color primarycolor = const Color(0xff7E89F0);
Color textcolor = Colors.black;
Color whitecolor = Colors.white;

String totalPrice(String quantity, String price) {
  var intQuantity = int.parse(quantity);
  var intPrince = int.parse(price);
  return (intQuantity * intPrince).toString();
}

final stores = [
  'Bajrang Departmental Store',
  'Bharat Audio Center',
  'Gajanand Bhandar',
  'Khandelwal general store',
  'Khunteta Mobile',
  'Shree Govind Kirana Store',
  'Shree Hari The Grocery Point',
  'Singhal Kirana Store',
  'Vikas Mobile Shop',
];
