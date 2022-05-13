import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class itemsview extends StatelessWidget {
  final image;
  itemsview({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Items"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                'All Shops deliver ' + image['iname'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )),
            ),
          ],
        ));
  }
}
