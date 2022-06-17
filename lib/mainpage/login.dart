// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartking/constant/auth_controller.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/foregetpassword.dart';
import 'package:kartking/mainpage/homescreen.dart';
import 'package:kartking/mainpage/register.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

// ignore: camel_case_types
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

// ignore: camel_case_types
class _LoginState extends State<Login> {
  UserProvider? userProvider;

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthController().logininUsers(email.text, password.text);
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      // ignore: use_build_context_synchronously
      showSnakBar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const homescreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        color: primarycolor,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 110,
                    child: Image.asset(
                      "assets/images/kartlogo.png",
                      fit: BoxFit.contain,
                    )),
                const Divider(),
                TextFormField(
                    autofocus: false,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,

                    // validation
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: isObscure,
                  autofocus: false,
                  controller: password,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Enter valid Password(Min. 6 Characters)";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    password.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.vpn_key),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: whitecolor,
                  child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        signIn(email.text, password.text);
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Register())));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen()));
                      },
                      child: const Text(
                        "Forget Password ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: textcolor,
                ),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: SignInButton(
                    Buttons.Google,
                    text: 'Sign in with Google',
                    onPressed: () {
                      AuthController().googleSignUp(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const homescreen())),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    } catch (e) {
      debugPrint("Login error $e");
    }
  }
}
