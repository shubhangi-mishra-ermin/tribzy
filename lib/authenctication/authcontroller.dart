import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile2.dart';
import 'package:tribzyco/authenctication/signup.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/navigationpage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> login(String email, String password) async {
    isLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => MainScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void navigateToSignUp() {
    Get.to(() => SignupPage());
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void signUpWithEmailPassword(
      String email, String password, String username) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user?.uid ?? "";

      bool? isInSanFrancisco = prefs!.getBool('isInSanFrancisco');
      // bool? isInSanFrancisco = prefs!.getBool('isInSanFrancisco');
      print("isInSanFrancisco :: $isInSanFrancisco");
      Map<String, dynamic> userData;

      if (isInSanFrancisco != null && isInSanFrancisco) {
        userData = {
          'email': email,
          'password': password,
          'username': username,
          'name': '',
          'profile_complete': false,
          'profile_pic': '',
          'country': '',
          'linkedinUrl': '',
          'gender': '',
          'interests': [],
          'personality': '',
          'state': '',
          'travel': '',
          'idea_name': '',
          'idea_in_oneline': '',
          'website_url': '',
          'domainIdea': '',
          'workingOn': '',
          'connectWIth': '',
        };
        Get.off(() => CompleteProfileScreen2(userId: userId));
      } else {
        userData = {
          'email': email,
          'password': password,
          'username': username,
          'profile_complete': false,
          'profile_pic': '',
          'dob': '',
          'age': '',
          'career_path': '',
          'country': '',
          'degree_type': '',
          'diet_preference': '',
          'gender': '',
          'interests': [],
          'major': '',
          'personality': '',
          'pet_friendly': true,
          'rating_cookingskill': '',
          'sleep_pattern': '',
          'smoke_or_drink': '',
          'state': '',
          'travel': '',
        };
        Get.off(() => CompleteProfileScreen(userId: userId));
      }

      await firestore.collection('Users').doc(userId).set(userData);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        Get.offAll(() => MainScreen());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading(true);
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        await _auth.signInWithCredential(credential);
        Get.offAll(() => MainScreen());
      }
    } catch (e) {
      print("error :: ${e.toString()}");
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
