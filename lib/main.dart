import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/splashScreen.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
final user = FirebaseAuth.instance.currentUser!;
String currentUserCredential = user.uid;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider:
        ReCaptchaV3Provider('6LdLDgcqAAAAAJFvrI0kr62O4916hbnJGPJ91kUF'),
    androidProvider: AndroidProvider.playIntegrity,
    // appleProvider: AppleProvider.appAttest,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tribzy',
      home: CompleteProfileScreen()
      // home: SplashScreen(),
    );
  }
}
