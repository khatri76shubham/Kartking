import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/home/items.dart';
import 'package:kartking/location.dart';

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

Widget bottombar({ontap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 200,
      height: 150,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: whitecolor,
              boxShadow: [
                BoxShadow(
                  color: primarycolor,
                  offset: Offset(1.0, 3.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deliverable address :-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Text('Home'),
                    ],
                  ),
                  Text(
                    '4-E-263,J.N.V colony , bikaner, rajasthan,334001',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: ontap,
                    child: Text('change address',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.red)),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: textcolor,
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('hello'),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primarycolor,
                    boxShadow: [
                      BoxShadow(
                        color: textcolor,
                        offset: Offset(1.0, 3.0), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Pay Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _checkoutState extends State<checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottombar(ontap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => location()));
      }),
      appBar: AppBar(
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
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
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurantList[0].title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          SizedBox(height: 5),
                          Container(
                            height: 100,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(restaurantList[0].imageUrl),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
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
                        Row(
                          children: [
                            Text('prices'),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: demo_products.length,
                        itemBuilder: (context, index) => checkoutcart(index)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '+ Add items',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Item total',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          Text(
                            '1000',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            '-50',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand total',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            '950',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
