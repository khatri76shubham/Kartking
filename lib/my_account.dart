import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/location.dart';
import 'package:kartking/user_details.dart';
import 'package:kartking/user_provider.dart';
import 'mainpage/login.dart';

class myaccount extends StatefulWidget {
  UserProvider? userProvider;
  @override
  State<myaccount> createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
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

  XFile? imageXfile;
  final ImagePicker _Picker = ImagePicker();
  Future<void> _getImage() async {
    imageXfile = await _Picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXfile;
    });
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var userdata = widget.userProvider;
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
              Expanded(
                child: Container(
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
                                  Text(userdata!.currentdata!.userName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textcolor,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("welcome@gmail.c"),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => userdetail()));
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: primarycolor,
                                  child: CircleAvatar(
                                    radius: 12,
                                    child: Icon(
                                      Icons.edit,
                                      color: whitecolor,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    listTile(icon: Icons.shop_outlined, title: "My orders"),
                    listTile(
                      icon: Icons.location_on_outlined,
                      title: "location",
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => location()));
                      },
                    ),
                    listTile(
                        icon: Icons.person_outline,
                        title: "Refer A Friend",
                        press: () {}),
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
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              backgroundColor: whitecolor,
              radius: 47,
              child: GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 20,
                  backgroundColor: Colors.white,
                  backgroundImage: imageXfile == null
                      ? null
                      : FileImage(File(imageXfile!.path)),
                  child: imageXfile == null
                      ? Image(image: NetworkImage(''))
                      : null,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
