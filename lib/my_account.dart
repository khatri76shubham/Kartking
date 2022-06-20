import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kartking/about.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/location.dart';
import 'package:kartking/my_order.dart';
import 'package:kartking/provider/user_provider.dart';
import 'package:kartking/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mainpage/login.dart';
import 'package:flutter_share/flutter_share.dart';

// ignore: must_be_immutable
class Myaccount extends StatefulWidget {
  UserProvider? userProvider;
  UserModel? userData;

  Myaccount({Key? key}) : super(key: key);
  @override
  State<Myaccount> createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
//predefined single button use in listview

  Widget listTile(
      {required IconData icon, required String title, VoidCallback? press}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          onTap: press,
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

//set user data fetch from firebase

  @override
  void initState() {
    context.read<UserProvider>().getuserdata();

    super.initState();
  }

  final auth = FirebaseAuth.instance;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Consumer<UserProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return Stack(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),

                    //listview all buttons in my account

                    child: ListView(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (value.currentdata?.userName != null)
                                  Text(value.currentdata!.userName.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textcolor,
                                      )),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (value.currentdata?.userEmail != null)
                                  Text(value.currentdata!.userEmail.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textcolor,
                                      )),
                              ],
                            ),
                          )
                        ],
                      ),

                      //my orders

                      listTile(
                          icon: Icons.shop_outlined,
                          title: "My orders",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Myorders()));
                          }),

                      //location

                      listTile(
                        icon: Icons.location_on_outlined,
                        title: "location",
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Location()));
                        },
                      ),

                      //share

                      listTile(
                          icon: Icons.share_outlined,
                          title: "Share with Friend",
                          press: () {
                            FlutterShare.share(
                                title: "share",
                                linkUrl:
                                    "https://drive.google.com/drive/folders/167bc-6HOrY4TnJCt4qStUwUbRN6MBTke?usp=sharing");
                          }),

                      //term and condition

                      listTile(
                          icon: Icons.file_copy_outlined,
                          title: "Term's & Condition",
                          press: () {
                            final Uri url = Uri.parse(
                                'https://drive.google.com/file/d/1nDj1-Ydzhnzs0_uvhHmg2G_ai1FsJOFt/view');
                            launchUrl(url);
                          }),

                      //privacy policy

                      listTile(
                          icon: Icons.policy_outlined,
                          title: "Privacy policy",
                          press: () {
                            final Uri url = Uri.parse(
                                'https://drive.google.com/file/d/1li0zdem5QsmaADJNaCH0-7LcwN0wJ-8y/view?usp=sharing');
                            launchUrl(url);
                          }),

                      //About

                      listTile(
                          icon: Icons.add_chart,
                          title: "About",
                          press: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const About()));
                          }),

                      //logout

                      listTile(
                        icon: Icons.exit_to_app_outlined,
                        title: "Log out",
                        press: () async {
                          FirebaseAuth.instance.signOut();
                          storage.deleteAll();
                          await googleSignIn.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
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
                radius: 48,
                child: const CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images/kartlogo.png"),
                ),
              ),
            ),
            if (value.currentdata?.userImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 30),
                child: CircleAvatar(
                  backgroundColor: whitecolor,
                  radius: 48,
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        '${value.currentdata?.userImage.toString()}'),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
