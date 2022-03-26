import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/itemsview.dart';

class items extends StatelessWidget {
  final int index;

  const items({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => itemsview(image: demo_products[index])));
        },
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(demo_products[index].image))),
            ),
            Text(demo_products[index].title),
          ],
        ),
      ),
    );
  }
}
