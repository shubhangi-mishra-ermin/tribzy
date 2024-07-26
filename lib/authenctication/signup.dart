import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/progressHud.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/authcontroller.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/authenctication/widget/socialmediabutton.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/validatorts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController()); 

    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(
      ),backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: ProgressHUD(
          isLoading: authController.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                  ),
                  4.ph,
                  Text(
                    'Username',
                    style: AppTextStyle.mediumgrey14,
                  ),
                  1.ph,
                  TextFeildStyle(
                    hintText: 'Sammy',
                    fillColor: Color(0xffFAFBFB),
                    validation: FormValidators.validateFirstName,
                    textAlignVertical: TextAlignVertical.center,
                    controller: _nameController,
                    onChanged: (value) {},
                  ),
                  2.ph,
                  Text(
                    'Email',
                    style: AppTextStyle.mediumgrey14,
                  ),
                  1.ph,
                  TextFeildStyle(
                    hintText: 'Sammy@gmail.com',
                    fillColor: Color(0xffFAFBFB),
                    textAlignVertical: TextAlignVertical.center,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                  ),
                  2.ph,
                  Text(
                    'Password',
                    style: AppTextStyle.mediumgrey14,
                  ),
                  1.ph,
                  TextFeildStyle(
                    obscureText: true,
                    validation: FormValidators.validatePassword,
                    textAlignVertical: TextAlignVertical.center,
                    controller: _passwordController,
                    onChanged: (value) {},
                    hintText: '********',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  6.ph,
                  Obx(() => CustomButton(
                      text: authController.isLoading.value
                          ? 'Signing Up...'
                          : 'Sign Up',
                      onPressed: () {
                        authController.signUpWithEmailPassword(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      })),
                  2.ph,
                  Center(
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
                  5.ph,
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or Continue with',
                          style: AppTextStyle.mediumgrey14.copyWith(fontSize: 12),
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
                        onPressed: authController.signInWithGoogle,
                      ),
                      SizedBox(width: 20),
                      SocialLoginButton(
                        iconPath: 'icons/app_logo.svg',
                      ),
                      SizedBox(width: 20),
                      SocialLoginButton(iconPath: 'icons/fb_logo.svg',
                        onPressed: authController.signInWithFacebook,
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

