import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/login.dart';

import '../constant/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email = TextEditingController();
  bool _isLoading = false;
  forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthController().forgotPassword(email.text);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      showSnakBar("Link has been send to your email", context);
      Navigator.push(context, MaterialPageRoute(builder: (_) => const login()));
    } else {
      showSnakBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                    color: Colors.black,
                    letterSpacing: .5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: email,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter Email",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  forgotPassword();
                  email.clear();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: whitecolor,
                      borderRadius: BorderRadius.circular(30)),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Forget Password",
                          style: TextStyle(
                              color: textcolor,
                              letterSpacing: .5,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ));
  }
}
