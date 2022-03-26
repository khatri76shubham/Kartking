import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

Widget stores(Size size) {
  return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: restaurantList.length,
      itemBuilder: (context, index) {
        return itemBuilder(size, index, context);
      });
}

Widget itemBuilder(Size size, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => storeview(storeno: restaurantList[index])));
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: size.height / 2.5,
          width: size.width / 1.1,
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: size.width / 1.1,
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
                height: size.height / 12,
                width: size.width / 1.2,
                child: Row(
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
                      height: size.height / 25,
                      width: size.width / 7,
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
              Container(
                width: size.width / 1.2,
                child: Text(
                  "${restaurantList[index].locations}   \t\t\t\t\t\t\t\t\t\t\t\t\t\t  ${restaurantList[index].price} for one",
                  style: TextStyle(
                    fontSize: 12.9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
