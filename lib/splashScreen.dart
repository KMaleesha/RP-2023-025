import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';

import '../Provider/sign_in_provider.dart';
import '../utils/configt.dart';
import '../utils/next_Screen.dart';
import 'Screens/Users/screens/homeScreen.dart';
import 'Screens/Users/screens/loginScreen.dart';
import 'Screens/Users/screens/signUpScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //init state

  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //create a timer of 2 seconds

    Timer(const Duration(seconds: 2), () {
      // if(finish == ){
      //
      // }

      sp.isSignedIn == false
          ? nextScreen(context, const LoginScreen())
          : nextScreen(context, const HomeScreenAll());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Configt.app_background2),
            fit: BoxFit.fill),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Image(
                      image: AssetImage(Configt.appLogo),
                      height: 256,
                      width: 254,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 54),
                    Text(
                      'සාදරයෙන් පිළිගනිමු',
                      style: TextStyle(
                        fontSize: 32,
                        color: HexColor('#357EB2'),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'කතා',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#346A9B'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
