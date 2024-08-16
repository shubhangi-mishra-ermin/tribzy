import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tribzyco/screens/navigationPage2.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/screens/onboardingScreens/OnBoarding.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:tribzyco/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    Timer(Duration(seconds: 2), () => _navigateBasedOnUser());
  }

  Future<void> _navigateBasedOnUser() async {
    if (user != null) {
      await _checkUserLocation();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => user != null ? _getHomeScreen() : OnBoarding()),
    );
  }

  Future<void> _checkUserLocation() async {
    var location = loc.Location();
    loc.LocationData? currentLocation;

    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print('Could not get the location: $e');
      currentLocation = null;
    }

    if (currentLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
      Placemark place = placemarks[0];

      if (place.locality == "San Francisco") {
        await prefs!.setBool('isInSanFrancisco', true);
      } else {
        await prefs!.setBool('isInSanFrancisco', false);
      }
    } else {
      await prefs!.setBool('isInSanFrancisco', false);
    }
  }

  Widget _getHomeScreen() {
    bool? isInSanFrancisco = prefs!.getBool('isInSanFrancisco');
    if (isInSanFrancisco != null && isInSanFrancisco) {
      return MainScreen2();
    } else {
      return MainScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset('icons/appLogo.svg'),
        ),
      ),
    );
  }
}
