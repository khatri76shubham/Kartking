import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kartking/constant/auth_controller.dart';
import 'package:kartking/mainpage/homescreen.dart';
import 'package:kartking/provider/address_provider.dart';
import 'package:kartking/provider/cart_provider.dart';
import 'package:kartking/constant/colors.dart';
import 'package:kartking/provider/favorite_provider.dart';
import 'package:kartking/mainpage/login.dart';
import 'package:kartking/constant/theme.dart';
import 'package:kartking/provider/my_order_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget nextscreen = const Login();
  AuthController authController = AuthController();

// checking theme state and cheklogin token
  @override
  void initState() {
    super.initState();
    checkLogin();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

//cheklogin token from mobile storage
  void checkLogin() async {
    var token = await authController.getToken();
    if (token != null) {
      setState(() {
        nextscreen = const homescreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) =>
                  UserProvider()), // fetch the user data and send to firebase
          ChangeNotifierProvider<Addressprovider>(
              create: (context) =>
                  Addressprovider()), //fetch the user address and send to firebase
          ChangeNotifierProvider<CartProvider>(
              create: (context) =>
                  CartProvider()), //fetch the user cart data and send to firebase
          ChangeNotifierProvider<YourCartProvider>(
              create: (context) =>
                  YourCartProvider()), //fetch the cart data for stores and send to firebase
          ChangeNotifierProvider<FavoriteProvider>(
              create: (context) =>
                  FavoriteProvider()), //fetch the favorite store data and send to firebase
          ChangeNotifierProvider<MyorderProvider>(
              create: (context) =>
                  MyorderProvider()), //fetch the user payment status and send to firebase
        ],
        child: MaterialApp(
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: currentTheme.currentTheme,
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
            nextScreen: nextscreen, //data from checklogin after token check
            splashTransition: SplashTransition.fadeTransition, //splash screen
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: primarycolor,
          ),
        ));
  }
}
