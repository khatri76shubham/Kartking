import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class storeview extends StatelessWidget {
  const storeview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        iconTheme: IconThemeData(color: textcolor),
        title: Text('store Overview'),
      ),
    );
  }
}
