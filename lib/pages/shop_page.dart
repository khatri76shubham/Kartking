import 'package:flutter/material.dart';

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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'cart',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Color(0xff7E89F0),
      ),
      body: const Center(
        child: Text('cart'),
      ),
    );
  }
}
