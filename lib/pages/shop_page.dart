import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

// ignore: camel_case_types
class shoppage extends StatefulWidget {
  const shoppage({Key? key}) : super(key: key);

  @override
  State<shoppage> createState() => _shoppageState();
}

// ignore: camel_case_types
class _shoppageState extends State<shoppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primarycolor,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Center(
            child: Column(
              children: [
                Text('Your cart', style: TextStyle(color: textcolor)),
                Text(
                  'items',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )),
    );
  }
}
