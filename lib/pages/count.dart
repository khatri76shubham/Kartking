import 'package:flutter/material.dart';
import 'package:kartking/cart_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:provider/provider.dart';

class count extends StatefulWidget {
  String? cartid;
  String? cartname;
  String? cartimage;
  String? cartprice;
  String? storeid;
  String? storeimage;

  count(
      {Key? key,
      this.cartid,
      this.storeid,
      this.cartimage,
      this.cartname,
      this.cartprice,
      this.storeimage})
      : super(key: key);

  @override
  State<count> createState() => _countState();
}

class _countState extends State<count> {
  int count = 1;
  bool istrue = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartprovider = Provider.of(context);
    YourCartProvider yourCartProvider = Provider.of(context);
    return Container(
        padding: EdgeInsets.all(8),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: istrue ? Colors.lightGreen : primarycolor,
            borderRadius: BorderRadius.circular(18)),
        child: istrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          istrue = false;
                        });
                      }
                      if (count > 1) {
                        setState(() {
                          count--;
                        });
                      }
                    },
                    child: Icon(Icons.remove, size: 15, color: textcolor),
                  ),
                  Text(
                    '$count',
                    style: TextStyle(
                        color: textcolor, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      yourCartProvider.yourcartdata(
                          storeid: widget.storeid,
                          storeimage: widget.storeimage);
                      cartprovider.addcartData(
                          storeid: widget.storeid,
                          cartid: widget.cartid,
                          cartimage: widget.cartimage,
                          cartname: widget.cartname,
                          cartprice: widget.cartprice,
                          cartquantity: '$count');
                    },
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color: textcolor,
                    ),
                  )
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      istrue = true;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 20,
                      ),
                      Text(
                        'add to cart',
                        style: TextStyle(color: textcolor),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
