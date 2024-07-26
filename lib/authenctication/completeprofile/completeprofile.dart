import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/outlinebutoon.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile2.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

import '../../utilities/colors.dart';

class CompleteProfileScreen extends StatefulWidget {
  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  int currentStep = 1;

  void nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('images/appLogo.svg'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('icons/login.svg'),
                SizedBox(width: 8),
                Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SvgPicture.asset('icons/menu.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete your profile',
              style: AppTextStyle.bold20,
            ),
            SizedBox(height: 20),
            StepperIndicator(currentStep: currentStep),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                // controller: ,
                child: currentStep == 1
                    ? Step1Content()
                    : currentStep == 2
                        ? Step2Content()
                        : Step3Content(),
              ),
            ),
            // SizedBox(height: 20),
            currentStep > 1
                ? Row(
                    children: [
                      Expanded(
                          child: CustomOutlineButton(
                              text: 'Previous', onPressed: previousStep)),
                      2.pw,
                      Expanded(
                        child: CustomButton(
                            text: currentStep == 3 ? 'Submit' : 'Next',
                            onPressed: () {
                              currentStep == 3
                                  ? nextPage(context, MainScreen())
                                  : nextStep();
                            }),
                      )
                    ],
                  )
                : CustomButton(
                    text: currentStep == 3 ? 'Submit' : 'Next',
                    onPressed: nextStep),
          ],
        ),
      ),
    );
  }
}

class StepperIndicator extends StatelessWidget {
  final int currentStep;

  const StepperIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStepIndicator(currentStep >= 1),
        1.pw,
        _buildStepIndicator(currentStep >= 2),
        1.pw,
        _buildStepIndicator(currentStep >= 3),
      ],
    );
  }

  Widget _buildStepIndicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          color: isActive ? Color(0xff6200EE) : Color(0xffE0E0E0),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5),
            right: Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
