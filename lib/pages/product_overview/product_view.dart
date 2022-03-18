import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

class productview extends StatefulWidget {
  productview({Key? key}) : super(key: key);

  @override
  State<productview> createState() => _productviewState();
}

class _productviewState extends State<productview> {
  Widget bonntonNavigationBar({
    required Color iconcolor,
    required Color backgroundcolor,
    required Color color,
    required String title,
    required IconData iconData,
  }) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(20),
            color: backgroundcolor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 17,
                  color: iconcolor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bonntonNavigationBar(
            iconcolor: Colors.white,
            backgroundcolor: primarycolor,
            color: textcolor,
            title: 'add to cart',
            iconData: Icons.favorite,
          ),
          bonntonNavigationBar(
              iconcolor: Colors.white,
              backgroundcolor: primarycolor,
              color: textcolor,
              title: 'Buy now',
              iconData: Icons.shop),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text(
          'Product Overview',
          style: TextStyle(color: textcolor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            child: Column(
              children: [
                ListTile(
                  title: Text('fresh'),
                  subtitle: Text('50'),
                ),
                Container(
                    height: 230,
                    padding: EdgeInsets.all(40),
                    child: Image.asset("assets/images/img_1.png")),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    'Available options',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: textcolor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
