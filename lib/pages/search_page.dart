import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/product_overview/product_view.dart';
import 'package:kartking/pages/store_overview/storeview.dart';

class searchpage extends StatefulWidget {
  searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  List<Restaurants> _searched = [];
  List<Product> _productsearch = [];

  onsearch(String searche) {
    setState(() {
      _productsearch = demo_products
          .where((Product) => Product.title.toLowerCase().contains(searche))
          .toList();
    });
    setState(() {
      _searched = restaurantList
          .where((Restaurants) =>
              Restaurants.title.toLowerCase().contains(searche))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Container(
            padding: EdgeInsets.all(5),
            height: 60,
            margin: EdgeInsets.all(20),
            child: TextField(
                cursorColor: textcolor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  fillColor: primarycolor,
                  filled: true,
                  hintText: "search for items and stores",
                  prefixIcon: Icon(
                    Icons.search,
                    color: textcolor,
                  ),
                ),
                onChanged: (value) => onsearch(value)),
          ),
          backgroundColor: primarycolor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("store").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _searched.length,
                  itemBuilder: (context, index) {
                    return searchbox(
                      user: _searched[index],
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                storeview(Index: snapshot.data?.docs[index])));
                      },
                    );
                  },
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _productsearch.length,
                    itemBuilder: (context, index) => productseachbox(
                          user: _productsearch[index],
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    productview(itemnu: demo_products[index])));
                          },
                        )),
              ],
            );
          },
        ));
  }
}

Widget productseachbox({required user, required ontap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    child: GestureDetector(
      onTap: ontap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: whitecolor,
            border: Border.all(color: primarycolor, width: 2),
          ),
          height: 350 / 2.5,
          width: 500 / 1.1,
          child: Row(
            children: [
              Container(
                height: 350 / 2.5,
                width: 120 / 1.1,
                decoration: BoxDecoration(
                    color: whitecolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                    ),
                    image: DecorationImage(
                        image: AssetImage(user.image), fit: BoxFit.cover)),
              ),
              Container(
                height: 350 / 2.5,
                width: 200 / 1.1,
                decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          child: Text(
                            "  ${user.price} ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "by shop name",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget searchbox({required user, required ontap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
    child: GestureDetector(
      onTap: ontap,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(18),
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: whitecolor,
              border: Border.all(color: primarycolor, width: 2),
            ),
            height: 400 / 2.5,
            width: 500 / 1.1,
            child: Column(
              children: [
                Container(
                  height: 350 / 4,
                  width: 500 / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(user.imageUrl), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: 350 / 12,
                  width: 500 / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: 350 / 25,
                        width: 500 / 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          user.rating,
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
                  width: 500 / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${user.locations}",
                        style: TextStyle(
                          fontSize: 12.9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " ${user.price} for one",
                        style: TextStyle(
                          fontSize: 12.9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
