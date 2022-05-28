import 'package:flutter/material.dart';

Color primarycolor = const Color(0xff7E89F0);
Color textcolor = Colors.black;
Color whitecolor = Colors.white;

String totalPrice(String quantity, String price) {
  var intQuantity = int.parse(quantity);
  var intPrince = int.parse(price);
  return (intQuantity * intPrince).toString();
}
