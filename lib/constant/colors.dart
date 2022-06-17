import 'package:flutter/material.dart';

//contant color use in pages
Color primarycolor = const Color(0xff7E89F0);
Color textcolor = Colors.black;
Color whitecolor = Colors.white;

//use for multiplying items quantities and price
String totalPrice(String quantity, String price) {
  var intQuantity = int.parse(quantity);
  var intPrince = int.parse(price);
  return (intQuantity * intPrince).toString();
}
