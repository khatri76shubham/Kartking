import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';

import 'mainpage/login.dart';

class myaccount extends StatefulWidget {
  myaccount({Key? key}) : super(key: key);

  @override
  State<myaccount> createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  @override
  Widget listTile(
      {required IconData icon, required String title, VoidCallback? press}) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          onTap: press,
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  final auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primarycolor,
        elevation: 0.0,
        title: Text(
          "My Account",
          style: TextStyle(
            fontSize: 18,
            color: textcolor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primarycolor,
              ),
              Container(
                height: 548,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: whitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 250,
                        height: 80,
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('shubham',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textcolor,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('shubhamkhatri767@gmail.com'),
                              ],
                            ),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: primarycolor,
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon(Icons.edit),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  listTile(icon: Icons.shop_outlined, title: "My orders"),
                  listTile(icon: Icons.location_on_outlined, title: "location"),
                  listTile(icon: Icons.person_outline, title: "Refer A Friend"),
                  listTile(
                      icon: Icons.file_copy_outlined,
                      title: "Term's & Condition"),
                  listTile(
                      icon: Icons.policy_outlined, title: "Privacy policy"),
                  listTile(icon: Icons.add_chart, title: "About"),
                  listTile(
                    icon: Icons.exit_to_app_outlined,
                    title: "Log out",
                    press: () {
                      auth.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => login()));
                    },
                  ),
                ]),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: textcolor,
              child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/kartlogo.png",
                  ),
                  radius: 45,
                  backgroundColor: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
