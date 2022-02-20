import 'package:flutter/material.dart';

// ignore: camel_case_types
class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

// ignore: camel_case_types
class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('search'),
      ),
    );
  }
}
