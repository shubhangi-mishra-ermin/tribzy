import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tribzyco/Widget/splashScreen.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
final user = FirebaseAuth.instance.currentUser!;
String currentUserCredential = user.uid;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tribzy',
      // home: CommunityDetails(),
      home: LoginPage(),
    );
  }
}
