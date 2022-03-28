import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/items.dart';

class checkout extends StatefulWidget {
  checkout({Key? key}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

Widget checkoutcart(index) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SizedBox(
              height: 35,
              width: 50,
              child: Image(
                image: AssetImage(demo_products[index].image),
                fit: BoxFit.cover,
              )),
          Container(
              color: whitecolor,
              width: 100,
              height: 20,
              child: Text(demo_products[index].title)),
        ],
      ),
      Container(
        width: 85,
        height: 30,
        decoration: BoxDecoration(
            border: Border.all(color: primarycolor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Icon(Icons.remove),
            ),
            Container(
              height: double.infinity,
              width: 20,
              child: Center(
                child: Text('1'),
              ),
            ),
            Container(
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
      Container(
          width: 40,
          height: 20,
          color: whitecolor,
          child: Text(demo_products[index].price))
    ],
  );
}

class _checkoutState extends State<checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your order",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                Text(
                  'From',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  restaurantList[0].title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: 300,
            child: Image(
                image: NetworkImage(restaurantList[0].imageUrl),
                fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        Text('items'),
                      ],
                    ),
                    Text('prices')
                  ],
                ),
                const Divider(),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: demo_products.length,
                    itemBuilder: (context, index) => checkoutcart(index))
              ],
            ),
          )
        ],
      ),
    );
  }
}
