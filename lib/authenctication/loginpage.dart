import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/signup.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'images/appLogo.svg',
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('icons/login.svg'),
                1.pw,
                Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SvgPicture.asset('icons/menu.svg'),
          ),
        ],
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              4.ph,
              Text(
                'Email',
                style: AppTextStyle.mediumgrey14,
              ),
              1.ph,
              TextFeildStyle(
                hintText: 'Sammy@gmail.com',
                fillColor: Color.fromARGB(255, 105, 110, 110),
              ),
              4.ph,
              Text(
                'Password',
                style: AppTextStyle.mediumgrey14,
              ),
              1.ph,
              TextFeildStyle(
                obscureText: obscure,
                hintText: '********',
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),
                // decoration: InputDecoration(

                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(8),
                //     borderSide: BorderSide(color: Colors.black26),
                //   ),

                // ),
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
              CustomButton(
                  text: 'Log In',
                  onPressed: () {
                    nextPage(context, MainScreen());
                  }),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  nextPage(context, SignupPage());
                },
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
                  SocialLoginButton(iconPath: 'icons/google_logo.svg'),
                  SizedBox(width: 20),
                  SocialLoginButton(iconPath: 'icons/app_logo.svg'),
                  SizedBox(width: 20),
                  SocialLoginButton(iconPath: 'icons/fb_logo.svg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String iconPath;

  const SocialLoginButton({required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset(iconPath, height: 24),
    );
  }
}
