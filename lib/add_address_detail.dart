import 'package:flutter/material.dart';

class addressdetail extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keboardtype;
  final String labtext;
  final int max;

  const addressdetail(
      {Key? key,
      required this.controller,
      required this.keboardtype,
      required this.labtext,
      required this.max})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: max,
      keyboardType: keboardtype,
      controller: controller,
      decoration: InputDecoration(labelText: labtext),
    );
  }
}
