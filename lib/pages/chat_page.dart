import 'package:flutter/material.dart';

// ignore: camel_case_types
class chatpage extends StatefulWidget {
  const chatpage({Key? key}) : super(key: key);

  @override
  State<chatpage> createState() => _chatpageState();
}

// ignore: camel_case_types
class _chatpageState extends State<chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Color(0xff7E89F0),
      ),
      body: const Center(
        child: Text('chat'),
      ),
    );
  }
}
