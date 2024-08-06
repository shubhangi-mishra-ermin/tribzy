import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile.dart';
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
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("userCredential :: $userCredential");
      print("currentUserCredential :: $currentUserCredential");
      print(
          "FirebaseAuth.instance.currentUse :: ${FirebaseAuth.instance.currentUser?.uid ?? ""}");

      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
// final user = FirebaseAuth.instance.currentUser!;
// String currentUserCredential = user.uid;
      await firestore.collection('Users').doc(userId).set({
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
      });

      Get.off(() => CompleteProfileScreen(userId: userId));
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
