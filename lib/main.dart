import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kartking/address_provider.dart';
import 'package:kartking/cart_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/favorite_provider.dart';
import 'package:kartking/mainpage/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<addressprovider>(
              create: (context) => addressprovider()),
          ChangeNotifierProvider<CartProvider>(
              create: (context) => CartProvider()),
          ChangeNotifierProvider<YourCartProvider>(
              create: (context) => YourCartProvider()),
          ChangeNotifierProvider<FavoriteProvider>(
              create: (context) => FavoriteProvider()),
        ],
        child: MaterialApp(
          home: AnimatedSplashScreen(
            duration: 500,
            splash: Column(
              children: [
                Expanded(
                  child: Image.asset("assets/images/kartlogo.png"),
                ),
                const Text(
                  'Kart King',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            centered: true,
            nextScreen: const login(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: primarycolor,
          ),
        ));
  }
}
