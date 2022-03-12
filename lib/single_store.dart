import 'package:flutter/material.dart';

class singlestore extends StatelessWidget {
  final String storeimage;
  final String storename;
  final VoidCallback onTap;
  singlestore(
      {required this.storeimage, required this.storename, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 230,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(storeimage),
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      storename,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
