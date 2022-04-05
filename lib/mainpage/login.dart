// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/foregetpassword.dart';
import 'package:kartking/mainpage/homescreen.dart';
import 'package:kartking/mainpage/register.dart';
import 'package:provider/provider.dart';

import '../user_provider.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  UserProvider? userProvider;
  Future _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider!.addUserData(
        currentUser: user,
        userEmail: user!.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );

      return user;
    } catch (e) {
      print(e);
    }
  }

  late String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xff7E89F0),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/kartlogo.png",
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Email"),
                )),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  obscureText: true,
                  cursorColor: textcolor,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Password"),
                )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage()));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: () {
                    auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const homescreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.07),
                    primary: Colors.black,
                    padding: const EdgeInsets.all(8),
                    shape: const StadiumBorder(),
                    elevation: 5,
                  ),
                  child: const Text("Login")),
            ),
            Divider(),
            SizedBox(
              height: 50,
              width: 350,
              child: SignInButton(
                Buttons.Google,
                text: 'Sign in with Google',
                onPressed: () {
                  _googleSignUp().then(
                    // ignore: non_constant_identifier_names
                    (Value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const homescreen(),
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have account ?",
                    style: TextStyle(fontSize: 16, color: Color(0xfb721C1C)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const register()));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class userprovider {}
