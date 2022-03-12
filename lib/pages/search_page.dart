import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

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
          backgroundColor: Color(0xff7E89F0),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  fillColor: primarycolor,
                  filled: true,
                  hintText: "search for items and stores",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
