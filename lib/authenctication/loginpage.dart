import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/progressHud.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/authcontroller.dart';
import 'package:tribzyco/authenctication/widget/socialmediabutton.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/validatorts.dart';

import '../Widget/appbar.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: CustomAppBar(
      ), backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: ProgressHUD(
          isLoading: _authController.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
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
                  SizedBox(height: 16),
                  Text(
                    'Password',
                    style: AppTextStyle.mediumgrey14,
                  ),
                  SizedBox(height: 8),
                  TextFeildStyle(
                    obscureText: true,
                    validation: FormValidators.validatePassword,
                    textAlignVertical: TextAlignVertical.center,
                    controller: _passwordController,
                    hintText: '********',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyle.mediumgrey14,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Obx(() {
                    return CustomButton(
                      text: 'Log In',
                      onPressed: _authController.isLoading.value
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _authController.login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                              }
                            },
                    );
                  }),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: _authController.navigateToSignUp,
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyle.mediumgrey14,
                          children: [
                            TextSpan(
                              text: 'sign up',
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue with',
                          style:
                              AppTextStyle.mediumgrey14.copyWith(fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        iconPath: 'icons/google_logo.svg',
                        onPressed: _authController.signInWithGoogle,
                      ),
                      SizedBox(width: 20),
                      SocialLoginButton(
                        iconPath: 'icons/app_logo.svg',
                      ),
                      SizedBox(width: 20),
                      SocialLoginButton(iconPath: 'icons/fb_logo.svg',
                        onPressed: _authController.signInWithFacebook,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


