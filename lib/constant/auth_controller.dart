import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kartking/mainpage/homescreen.dart';
import 'package:kartking/provider/user_provider.dart';

class AuthController {
  Stream<User?> get authChanges => FirebaseAuth.instance.authStateChanges();
  User? get user => FirebaseAuth.instance.currentUser;
  final storage = const FlutterSecureStorage();

  Future<String> signInUser(
      String fullname, String username, String email, String password) async {
    String res = "some error";
    try {
      if (fullname.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        debugPrint(user.user!.email);
        // String downloadUrl = await _uploadImageToStorage(image);
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.user!.uid)
            .set({
          "fullName": fullname,
          "username": username,
          "email": email,
          // "image": downloadUrl
        });
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      res = e.toString();
      if (kDebugMode) {
        print("12234 $res");
      }
    }
    return res;
  }

  //function to login in users
  logininUsers(String email, String password) async {
    String res = "some error occur";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        res = "success";
        if (kDebugMode) {
          print("you are now logged in");
        }
      } else {
        res = "Please, fields must not be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //forget Password
  Future<String> forgotPassword(String email) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (kDebugMode) {
          print("Resend link is send to your email");
        }
        res = "success";
      } else {
        res = "Email field must not be empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//googlesignin
  UserProvider? userProvider;
  Future googleSignUp(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      storeToken(userCredential);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const homescreen()),
          (route) => false);
      final User? user = (await auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider!.addUserData(
        currentUser: user,
        userEmail: user!.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );

      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void storeToken(UserCredential userCredential) async {
    if (kDebugMode) {
      print("storing token and data");
    }
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    await storage.write(key: "token", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}

showSnakBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
