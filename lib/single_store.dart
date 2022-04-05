import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class singlestore extends StatelessWidget {
  final int index;
  singlestore({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => storeview(storeno: restaurantList[index])));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                height: 500 / 4,
                width: 300 / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  image: DecorationImage(
                      image: NetworkImage(restaurantList[index].imageUrl),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                height: 500 / 7,
                width: 300 / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurantList[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 500 / 25,
                      width: 300 / 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        restaurantList[index].rating,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
