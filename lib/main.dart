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
  Widget nextscreen = login();
  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    checkLogin();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  void checkLogin() async {
    var token = await authController.getToken();
    if (token != null) {
      setState(() {
        nextscreen = homescreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
          ChangeNotifierProvider<Addressprovider>(
              create: (context) => Addressprovider()),
          ChangeNotifierProvider<CartProvider>(
              create: (context) => CartProvider()),
          ChangeNotifierProvider<YourCartProvider>(
              create: (context) => YourCartProvider()),
          ChangeNotifierProvider<FavoriteProvider>(
              create: (context) => FavoriteProvider()),
          ChangeNotifierProvider<MyorderProvider>(
              create: (context) => MyorderProvider()),
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
            nextScreen: nextscreen,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: primarycolor,
          ),
        ));
  }
}
