import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/pages/cart_page.dart';
import 'package:kartking/pages/count.dart';

class productview extends StatelessWidget {
  final itemnu;
  final sid;

  productview({Key? key, itemno, required this.itemnu, this.sid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primarycolor,
        bottomNavigationBar: Container(
          color: whitecolor,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  count(
                    storeid: sid['sname'], //storeid
                    cartname: itemnu['iname'],
                    cartid: itemnu['iid'],
                    cartimage: itemnu['iimage'],
                    cartprice: itemnu['iprice'],
                  ),
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => cartpage()));
                        },
                        child: Center(
                            child: Text('View Cart',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ),
                  )
                ],
              )),
        ),
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
        body: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * .5,
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.12, left: 08, right: 08),
                  decoration: BoxDecoration(
                      color: whitecolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quantity',
                                    style: TextStyle(color: textcolor)),
                              ],
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: itemnu['iquantity'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(fontWeight: FontWeight.bold))
                              ]),
                            )
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemnu['iname'],
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
                              text: itemnu['iprice'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color: whitecolor,
                                      fontWeight: FontWeight.bold),
                            )
                          ])),
                          Expanded(
                              child: Image.network(
                            itemnu['iimage'],
                            fit: BoxFit.fill,
                          )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
