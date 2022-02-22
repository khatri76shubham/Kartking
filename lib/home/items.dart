import 'package:flutter/material.dart';

class items extends StatefulWidget {
  items({Key? key}) : super(key: key);

  @override
  State<items> createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2Farchive%2F5cce31c3c20f0f4fa192572d652107f0f6404ffe'))),
          ),
          SizedBox(
            height: 15,
          ),
          Text("data"),
        ],
      ),
    );
  }
}
