import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/home/homapage.dart';
import 'package:tribzyco/screens/navigationpage.dart';

import 'package:tribzyco/utilities/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // print("user :: $user");
    // print("currentUserCredential :: $currentUserCredential");
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen())));
    // MaterialPageRoute(
    //     builder: (context) =>
    //         user != null ? MainScreen() : LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7DEFF),
      body: SafeArea(
          child: Center(
        child: SvgPicture.asset('images/groupimage_home.svg'),
      )
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: MediaQuery.of(context).size.height / 4.5,
          //       child: Image(
          //         fit: BoxFit.fitWidth,
          //         image: AssetImage("lib/assets/images/splashvc.png"),
          //       ),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width / 1.8,
          //       height: MediaQuery.of(context).size.height / 4.5,
          //       child: Image(
          //         fit: BoxFit.fitWidth,
          //         image: AssetImage("lib/assets/images/logo.png"),
          //       ),
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height / 5.5,
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
