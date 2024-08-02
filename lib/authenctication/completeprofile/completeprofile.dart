import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/outlinebutoon.dart';
import 'package:tribzyco/authenctication/widget/chipgroup.dart';
import 'package:tribzyco/authenctication/widget/dropdown.dart';
import 'package:tribzyco/authenctication/widget/radiobutton.dart';
import 'package:tribzyco/authenctication/widget/sliderstep.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

import '../../utilities/colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompleteProfileController extends GetxController {
  var currentStep = 1.obs;
  var isLoading = false.obs;

  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController degreeTypeController = TextEditingController();
  final TextEditingController careerPathController = TextEditingController();
  var gender = ''.obs;
  var personality = ''.obs;
  var interests = <String>[].obs;
  var dietPreference = ''.obs;
  var petFriendly = true.obs;
  var cookingSkillRating = ''.obs;
  var sleepPattern = ''.obs;
  var smokeOrDrink = ''.obs;
  var travelFrequency = ''.obs;

  void nextStep() {
    if (currentStep < 3) {
      currentStep++;
    } else {
      saveProfileData();
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      currentStep--;
    }
  }

  void saveProfileData() async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserCredential)
          .set({
        'age': ageController.text,
        'career_path': careerPathController.text,
        'country': countryController.text,
        'degree_type': degreeTypeController.text,
        'diet_preference': dietPreference.value,
        'gender': gender.value,
        'interests': interests,
        'major': majorController.text,
        'personality': personality.value,
        'pet_friendly': petFriendly.value,
        'rating_cookingskill': cookingSkillRating.value,
        'sleep_pattern': sleepPattern.value,
        'smoke_or_drink': smokeOrDrink.value,
        'state': stateController.text,
        'travel': travelFrequency.value,
      });

      Get.offAll(() => MainScreen());
    } catch (e) {
      print('Error saving profile data: $e');
      Get.snackbar('Error', e.toString());
    }
  }
}

class CompleteProfileScreen extends StatefulWidget {
  final String userId;

  CompleteProfileScreen({required this.userId});

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final CompleteProfileController controller =
      Get.put(CompleteProfileController());

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
            Obx(() =>
                StepperIndicator(currentStep: controller.currentStep.value)),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (controller.currentStep.value == 1) {
                    return Step1Content(
                      countryController: controller.countryController,
                      stateController: controller.stateController,
                      ageController: controller.ageController,
                      petFriendlyCallback: (value) =>
                          controller.petFriendly.value = value,
                      sleepPatternCallback: (value) =>
                          controller.sleepPattern.value = value,
                      smokeOrDrinkCallback: (value) =>
                          controller.smokeOrDrink.value = value,
                    );
                  } else if (controller.currentStep.value == 2) {
                    return Step2Content(
                      genderCallback: (value) =>
                          controller.gender.value = value,
                      personalityCallback: (value) =>
                          controller.personality.value = value,
                      interestsCallback: (value) =>
                          controller.interests.value = value,
                      dietPreferenceCallback: (value) =>
                          controller.dietPreference.value = value,
                      cookingSkillRatingCallback: (value) => controller
                          .cookingSkillRating.value = value.toString(),
                      travelFrequencyCallback: (value) =>
                          controller.travelFrequency.value = value,
                    );
                  } else {
                    return Step3Content(
                      majorController: controller.majorController,
                      degreeTypeController: controller.degreeTypeController,
                      careerPathController: controller.careerPathController,
                    );
                  }
                }),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value)
                Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );

              if (controller.currentStep.value > 1) {
                return Row(
                  children: [
                    Expanded(
                        child: CustomOutlineButton(
                            text: 'Previous',
                            onPressed: controller.previousStep)),
                    2.pw,
                    Expanded(
                      child: CustomButton(
                          text: controller.currentStep.value == 3
                              ? 'Submit'
                              : 'Next',
                          onPressed: () {
                            controller.nextStep();
                          }),
                    )
                  ],
                );
              } else {
                return CustomButton(
                    text: controller.currentStep.value == 3 ? 'Submit' : 'Next',
                    onPressed: controller.nextStep);
              }
            }),
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

class Step1Content extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController ageController;
  final Function(bool) petFriendlyCallback;
  final Function(String) sleepPatternCallback;
  final Function(String) smokeOrDrinkCallback;

  const Step1Content({
    required this.countryController,
    required this.stateController,
    required this.ageController,
    required this.petFriendlyCallback,
    required this.sleepPatternCallback,
    required this.smokeOrDrinkCallback,
  });

  @override
  _Step1ContentState createState() => _Step1ContentState();
}

class _Step1ContentState extends State<Step1Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habits and Preferences',
              style: AppTextStyle.semibold18,
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: 'Which country are you from?',
              controller: widget.countryController,
              items: ['Select Country', 'India', 'Country 1', 'Country 2'],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: 'Which state are you from?',
              controller: widget.stateController,
              items: ['Select State', 'Delhi', 'State 1', 'State 2'],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: 'What is your Age',
              controller: widget.ageController,
              items: ['18-24', '24-30', '30+'],
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: 'What is your sleep pattern like?',
              options: ['Morning person', 'Night owl', 'No fixed timings'],
              onChanged: widget.sleepPatternCallback,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: 'How often do you smoke or drink?',
              options: ['Sometimes', 'More often', 'Never'],
              onChanged: widget.smokeOrDrinkCallback,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: 'Are you pet-friendly?',
              options: ['Yes', 'No'],
              onChanged: (value) => widget.petFriendlyCallback(value == 'Yes'),
            ),
          ],
        ),
      ),
    );
  }
}

class Step2Content extends StatefulWidget {
  final Function(String) genderCallback;
  final Function(String) personalityCallback;
  final Function(List<String>) interestsCallback;
  final Function(String) dietPreferenceCallback;
  final Function(double) cookingSkillRatingCallback;
  final Function(String) travelFrequencyCallback;

  const Step2Content({
    required this.genderCallback,
    required this.personalityCallback,
    required this.interestsCallback,
    required this.dietPreferenceCallback,
    required this.cookingSkillRatingCallback,
    required this.travelFrequencyCallback,
  });

  @override
  _Step2ContentState createState() => _Step2ContentState();
}

class _Step2ContentState extends State<Step2Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Characteristics and Interests',
              style: AppTextStyle.semibold18,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: 'What is your gender?',
              options: ['Male', 'Female', 'Other'],
              onChanged: widget.genderCallback,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: 'What is your personality like?',
              options: [
                'Extroverted',
                'Introverted',
                'A mix of both',
                'Prefer not to say'
              ],
              onChanged: widget.personalityCallback,
            ),
            SizedBox(height: 20),
            CustomChipGroup(
              label: '9. What are your hobbies and interests?',
              options: [
                'Movies',
                'Badminton',
                'Cricket',
                'Singing',
                'Traveling',
                'Dancing',
                'Gaming',
                'Cooking',
                'Reading'
              ],
              onChanged: widget.interestsCallback,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: '10. What is your diet preference?',
              options: ['Vegetarian', 'Non-vegetarian', 'Vegan'],
              onChanged: widget.dietPreferenceCallback,
            ),
            SizedBox(height: 20),
            CustomSliderGroup(
              label: 'Rate your cooking skills on a scale of 1 to 10.',
              initialValue: 4,
              min: 1,
              max: 10,
              onChanged: widget.cookingSkillRatingCallback,
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: '12. How often do you travel?',
              options: ['Sometimes', 'More often', 'Never'],
              onChanged: widget.travelFrequencyCallback,
            ),
          ],
        ),
      ),
    );
  }
}

class Step3Content extends StatefulWidget {
  final TextEditingController majorController;
  final TextEditingController degreeTypeController;
  final TextEditingController careerPathController;

  const Step3Content({
    required this.majorController,
    required this.degreeTypeController,
    required this.careerPathController,
  });

  @override
  _Step3ContentState createState() => _Step3ContentState();
}

class _Step3ContentState extends State<Step3Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic and Background',
              style: AppTextStyle.semibold18,
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: '13. What is your major?',
              controller: widget.majorController,
              items: [
                'Select Major',
                'CS',
                'ECE',
                'ISOM',
                'Chemical',
                'Others'
              ],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: '14. What is your degree type?',
              controller: widget.degreeTypeController,
              items: ['Select degree type', 'UG', 'Masters', 'PhD', 'Others'],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: '15. What is your career path?',
              controller: widget.careerPathController,
              items: [
                'Select career domain',
                'Computer Science: UI/UX, Frontend, Backend, Mobile Development',
                'Electronics and Communication: VLSI, Circuit Design, Networking',
                'Other Domains: Add relevant options as needed'
              ],
            ),
          ],
        ),
      ),
    );
  }
}
