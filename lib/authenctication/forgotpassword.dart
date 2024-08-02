import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/authcontroller.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widget/appbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController =
      Get.put(AuthController()); // Ensure AuthController is available

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Forgot Your Password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Enter the email address associated with your account. We’ll send you a verification code to reset your password.",
                      style: AppTextStyle.medium14.copyWith(color: greyColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Email',
                      style: AppTextStyle.mediumgrey14,
                    ),
                    SizedBox(height: 8),
                    TextFeildStyle(
                      hintText: 'Sammy@gmail.com',
                      fillColor: Color(0xffFAFBFB),
                      textAlignVertical: TextAlignVertical.center,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 30),
                    Obx(() {
                      return CustomButton(
                        text: _authController.isLoading.value
                            ? 'Sending...'
                            : 'Send',
                        onPressed: _authController.isLoading.value
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _sendPasswordResetEmail();
                                }
                              },
                      );
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return _authController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  void _sendPasswordResetEmail() async {
    _authController.isLoading.value = true;
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      Get.snackbar('Success', 'Password reset email sent');
      // Optionally navigate to a different screen or perform other actions
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      _authController.isLoading.value = false;
    }
  }
}
