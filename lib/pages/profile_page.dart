import 'package:flutter/material.dart';

// ignore: camel_case_types
class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

// ignore: camel_case_types
class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('profile'),
    );
  }
}
