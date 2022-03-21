import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

// ignore: camel_case_types
class cartpage extends StatefulWidget {
  const cartpage({Key? key}) : super(key: key);

  @override
  State<cartpage> createState() => _cartpageState();
}

Widget cartitems(index) {
  return Container(
    padding: EdgeInsets.all(3),
    margin: EdgeInsets.all(3),
    decoration: BoxDecoration(border: Border.all(color: textcolor, width: .5)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 55, child: Image.asset(demo_products[index].image)),
            Text(demo_products[index].title,
                style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        Text(
          demo_products[index].price,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget cartshop(shopno) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: textcolor, width: 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurantList[shopno].title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                child: Icon(
                  Icons.delete,
                  color: textcolor,
                ),
              ),
            ],
          ),
          Divider(
            color: textcolor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('items'), Text('price')],
          ),
          Divider(),
          cartitems(0),
          cartitems(1),
          cartitems(2),
          cartitems(3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8),
                height: 50,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Buy Now",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('Total')
                  ],
                ),
                decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(color: textcolor, width: 1.5)),
              )
            ],
          )
        ],
      ),
    ),
  );
}

class _cartpageState extends State<cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primarycolor,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Center(
            child: Text('Your cart', style: TextStyle(color: textcolor)),
          )),
      body: ListView(
        children: [cartshop(0), cartshop(1), cartshop(2)],
      ),
    );
  }
}
