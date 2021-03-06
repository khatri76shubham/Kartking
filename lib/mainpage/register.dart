import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kartking/constant/auth_controller.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/mainpage/login.dart';
import 'package:kartking/model/user_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final fullName = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final userName = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  final confirmPasswordEditingController = TextEditingController();

  // ignore: unused_field
  bool _isLoading = false;
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullName.dispose();
    userName.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthController()
        .signInUser(fullName.text, userName.text, email.text, password.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      // ignore: use_build_context_synchronously
      return showSnakBar(res, context);
    } else {
      // ignore: use_build_context_synchronously
      return showSnakBar(
          "Congratulations account has been created for you", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                      controller: fullName,
                      keyboardType: TextInputType.name,

                      // validations
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return "Please enter your Full Name";
                        }
                        if (!regex.hasMatch(value)) {
                          return "Enter valid Name(Min. 3 Characters)";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fullName.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      autofocus: false,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,

                      // validatons
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                      //keyboardType: TextInputType.emai,

                      // validatons
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
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        //suffixIcon: Icon(Icons.visibility_off)
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Icon(isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      obscureText: isObscure,
                      autofocus: false,
                      controller: confirmPasswordEditingController,
                      //keyboardType: TextInputType.emailAddress,

                      // validations
                      validator: (value) {
                        if (confirmPasswordEditingController.text !=
                            password.text) {
                          return "Password don't matched";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        confirmPasswordEditingController.text = value!;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //suffixIcon: Icon(Icons.visibility_off)));
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            child: Icon(isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ))),
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
                        onPressed: () {
                          signUp(email.text, password.text);
                        },
                        child: Text(
                          "SignUp",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: textcolor,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ?",
                        style: TextStyle(
                          color: Colors.black,
                          // letterSpacing: .5,
                          fontSize: 14,
                          //fontWeight: FontWeight.bold
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
                                  builder: ((context) => const Login())));
                        },
                        child: const Text(
                          "SignIn",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: .5,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {
                  postDetailsToFirestore(),
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    } catch (e) {
      debugPrint("error in sign up $e");
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.userEmail = user!.email!;
    userModel.userUid = user.uid;
    userModel.userName = fullName.text;
    userModel.userImage = null;

    await firebaseFirestore.collection("usersData").doc(user.uid).set(
      {
        "userImage": userModel.userImage,
        "userName": userModel.userName,
        "userEmail": userModel.userEmail,
        "userUid": userModel.userUid,
      },
    );

    Fluttertoast.showToast(msg: "Account created successfully :)");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
