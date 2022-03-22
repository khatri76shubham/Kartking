import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class productview extends StatelessWidget {
  final Product itemnu;
  const productview({Key? key, itemno, required this.itemnu}) : super(key: key);

  Widget bottombar() {
    return Container(
      color: whitecolor,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addtocart(),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: primarycolor),
                  child: GestureDetector(
                    onTap: () {},
                    child: Center(
                        child: Text('Buy Now',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600))),
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primarycolor,
        bottomNavigationBar: bottombar(),
        appBar: AppBar(
          backgroundColor: primarycolor,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: primarycolor),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      padding: EdgeInsets.only(
                          top: size.height * 0.12, left: 08, right: 08),
                      // height: 500,
                      decoration: BoxDecoration(
                          color: whitecolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Quantity'),
                                      Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: primarycolor),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "weight\n",
                                        style: TextStyle(color: textcolor)),
                                    TextSpan(
                                        text: "12kg",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ]),
                                ))
                              ],
                            ),
                          ),
                          Text("About Product \n",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                              "Frozen vegetables are vegetables that have had their temperature reduced and maintained to below their freezing point for the purpose of storage and transportation (often for far longer than their natural shelf life would permit) until they are ready to be eaten. They may be commercially packaged or frozen at home."),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemnu.title,
                            style: TextStyle(
                                color: whitecolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(text: "Price\n"),
                                TextSpan(
                                  text: itemnu.price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color: whitecolor,
                                          fontWeight: FontWeight.bold),
                                )
                              ])),
                              Expanded(
                                  child: Image.asset(
                                itemnu.image,
                                fit: BoxFit.fill,
                              )),
                            ],
                          ),
                          Row(
                            children: [Container()],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class addtocart extends StatefulWidget {
  const addtocart({
    Key? key,
  }) : super(key: key);

  @override
  State<addtocart> createState() => _addtocartState();
}

class _addtocartState extends State<addtocart> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isAdded = !isAdded;
        setState(() {});
      },
      child: Container(
          padding: EdgeInsets.all(8),
          height: 50,
          decoration: BoxDecoration(
              color: isAdded ? Colors.lightGreen : primarycolor,
              borderRadius: BorderRadius.circular(18)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: isAdded
                    ? Icon(Icons.done)
                    : Icon(
                        Icons.shopping_cart,
                        size: 20,
                      ),
              ),
              Text(isAdded ? "added to cart" : 'Add to cart')
            ],
          ))),
    );
  }
}
