import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/outlinebutoon.dart';
import 'package:tribzyco/Widget/progressHud.dart';
import 'package:tribzyco/Widget/textfield.dart';
import 'package:tribzyco/authenctication/widget/chipgroup.dart';
import 'package:tribzyco/authenctication/widget/dropdown.dart';
import 'package:tribzyco/authenctication/widget/radiobutton.dart';
import 'package:tribzyco/authenctication/widget/sliderstep.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/validatorts.dart';

import '../../utilities/colors.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompleteProfileController2 extends GetxController {
  var currentStep = 1.obs;
  var isLoading = false.obs;

  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ideanameController = TextEditingController();
  final TextEditingController linkedinUrlController = TextEditingController();
  final TextEditingController onelinerController = TextEditingController();
  final TextEditingController webUrlController = TextEditingController();
  final TextEditingController domainIdeaController = TextEditingController();
  final TextEditingController workingOnController = TextEditingController();
  final TextEditingController connectWithController = TextEditingController();
  var gender = ''.obs;
  var personality = ''.obs;
  var interests = <String>[].obs;
  var dietPreference = ''.obs;
  var petFriendly = true.obs;
  var cookingSkillRating = ''.obs;
  var profilePic = ''.obs;
  var username = ''.obs;
  var sleepPattern = ''.obs;
  var smokeOrDrink = ''.obs;
  var travelFrequency = ''.obs;
  bool completeProfile = false;
  Map<String, dynamic> get initialDataStep12 => {
        'country': countryController.text,
        'state': stateController.text,
        'name': nameController.text,
        'linkedinUrl': linkedinUrlController.text,
      };
  Map<String, dynamic> get initialDataStep22 => {
        'gender': gender.value,
        'personality': personality.value,
        'interests': interests,
        // 'diet_preference': dietPreference.value,
        // 'rating_cookingskill': cookingSkillRating.value,
        // 'travel': travelFrequency.value,
      };
  Map<String, dynamic> get initialDataStep32 => {
        'idea_name': ideanameController.text,
        'idea_in_oneline': onelinerController.text,
        'website_url': webUrlController.text,
        'domainIdea': domainIdeaController.text,
        'workingOn': workingOnController.text,
        'connectWIth': connectWithController.text,
      };
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
      completeProfile = true;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserCredential)
          .set({
        'name': nameController.text, //
        'country': countryController.text, //
        'linkedinUrl': linkedinUrlController.text, //
        // 'diet_preference': dietPreference.value,
        'gender': gender.value,
        'interests': interests,
        'personality': personality.value,
        // 'pet_friendly': petFriendly.value,
        // 'sleep_pattern': sleepPattern.value,
        'smoke_or_drink': smokeOrDrink.value,
        'state': stateController.text, //
        'travel': travelFrequency.value,
        'idea_name': ideanameController.text,
        'idea_in_oneline': onelinerController.text,
        'website_url': webUrlController.text,
        'domainIdea': domainIdeaController.text,
        'workingOn': workingOnController.text,
        'connectWIth': connectWithController.text,
        'profile_complete': completeProfile,
      });

      Get.offAll(() => MainScreen());
    } catch (e) {
      print('Error saving profile data: $e');
      Get.snackbar('Error', e.toString());
    }
  }
}

class CompleteProfileScreen2 extends StatefulWidget {
  final String userId;

  CompleteProfileScreen2({required this.userId});

  @override
  _CompleteProfileScreen2State createState() => _CompleteProfileScreen2State();
}

class _CompleteProfileScreen2State extends State<CompleteProfileScreen2> {
  final CompleteProfileController2 controller =
      Get.put(CompleteProfileController2());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(),
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
                    return Step1Content2(
                      initialData: controller.initialDataStep12,
                      userId: widget.userId,
                      countryController: controller.countryController,
                      stateController: controller.stateController,
                      nameController: controller.nameController,
                      linkedinUrl: controller.linkedinUrlController,
                      // petFriendlyCallback: (value) =>
                      //     controller.petFriendly.value = value,
                      // sleepPatternCallback: (value) =>
                      //     controller.sleepPattern.value = value,
                      // smokeOrDrinkCallback: (value) =>
                      //     controller.smokeOrDrink.value = value,
                    );
                  } else if (controller.currentStep.value == 2) {
                    return Step2Content2(
                      initialData: controller.initialDataStep22,
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
                    return Step3Content2(
                      initialData: controller.initialDataStep32,
                      ideaName: controller.ideanameController,
                      onliner: controller.onelinerController,
                      weburl: controller.webUrlController,
                      connectWIth: controller.connectWithController,
                      domainIdea: controller.domainIdeaController,
                      workingOn: controller.workingOnController,
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

class Step1Content2 extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController stateController;
  final TextEditingController nameController;
  final TextEditingController linkedinUrl;
  final String userId;
  final bool showHeading;
  final Map<String, dynamic> initialData;

  const Step1Content2({
    required this.countryController,
    required this.stateController,
    required this.nameController,
    required this.linkedinUrl,
    required this.userId,
    this.showHeading = true,
    required this.initialData,
  });

  @override
  _Step1Content2State createState() => _Step1Content2State();
}

class _Step1Content2State extends State<Step1Content2> {
  String _fileName = '';
  Uint8List? filePath;
  bool _isAdding = false;
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _fileName = image.name;
      });

      filePath = await image.readAsBytes();

      await _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    setState(() {
      _isAdding = true;
    });

    try {
      String fileName = 'profile_${widget.userId}.jpg';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('Profile images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      String userId = widget.userId;
      if (userId.isNotEmpty && downloadURL.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .update({
          'profile_pic': downloadURL,
        });

        print('Profile image updated successfully');
        showSucessMessage(context, 'Profile image updated successfully');
      } else {
        print('User ID or download URL is null');
        showErrorMessage(
            context, 'Failed to upload image: Missing user ID or download URL');
      }
    } catch (e) {
      print('Error uploading image: $e');
      showErrorMessage(context, 'Failed to upload image');
    } finally {
      setState(() {
        _isAdding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 600,
      ),
      child: _isAdding
          ? Center(child: CircularProgressIndicator())
          : Card(
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
                    Text('1. What is your preferred name?',
                        style: AppTextStyle.semibold16),
                    SizedBox(height: 8),
                    TextFeildStyle(
                      hintText: '',
                      fillColor: Color(0xffFAFBFB),
                      validation: FormValidators.validateFirstName,
                      textAlignVertical: TextAlignVertical.center,
                      controller: widget.nameController,
                      onChanged: (value) {},
                      initialValue: widget.initialData['name'] == null ||
                              widget.initialData['name'] == ''
                          ? 'Enter Name'
                          : widget.initialData['name'],
                    ),
                    SizedBox(height: 20),
                    Text('2. Upload your Profile picture',
                        style: AppTextStyle.semibold16),
                    SizedBox(height: 8),
                    _fileName != ''
                        ? Stack(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.memory(
                                  filePath ?? Uint8List(0),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      filePath = null;
                                      _fileName = '';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    padding: EdgeInsets.all(2),
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (_fileName == '') {
                                    _pickImage();
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color(0xffF5F6F6),
                                  ),
                                  child: DottedBorder(
                                    color: primaryColor,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    dashPattern: [6, 3],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40),
                                      child: Center(
                                          child: SvgPicture.asset(
                                              'icons/upload.svg')),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    CustomDropdownField(
                        label: '3. Which country are you from?',
                        controller: widget.countryController,
                        items: [
                          'Select Country',
                          'India',
                          'Country 1',
                          'Country 2'
                        ],
                        initialValue: widget.initialData['country'] == ''
                            ? 'Select Country'
                            : widget.initialData['country']),
                    SizedBox(height: 20),
                    CustomDropdownField(
                      label: '4. Which state are you from?',
                      controller: widget.stateController,
                      items: ['Select State', 'Delhi', 'State 1', 'State 2'],
                      initialValue: widget.initialData['state'] == null ||
                              widget.initialData['state'] == ''
                          ? 'Select State'
                          : widget.initialData['state'],
                    ),
                    SizedBox(height: 20),
                    Text('12. Linkedin url', style: AppTextStyle.semibold16),
                    SizedBox(height: 8),
                    TextFeildStyle(
                      hintText: '',
                      fillColor: Color(0xffFAFBFB),
                      validation: FormValidators.validateFirstName,
                      textAlignVertical: TextAlignVertical.center,
                      controller: widget.linkedinUrl,
                      onChanged: (value) {},
                      initialValue: widget.initialData['linkedinUrl'] == null ||
                              widget.initialData['linkedinUrl'] == ''
                          ? 'Enter LinkedIn URL'
                          : widget.initialData['linkedinUrl'],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Step2Content2 extends StatefulWidget {
  final Function(String) genderCallback;
  final Function(String) personalityCallback;
  final Function(List<String>) interestsCallback;
  final Function(String) dietPreferenceCallback;
  final Function(double) cookingSkillRatingCallback;
  final Function(String) travelFrequencyCallback;
  final bool showHeading;
  final Map<String, dynamic> initialData;
  const Step2Content2({
    required this.genderCallback,
    required this.personalityCallback,
    required this.interestsCallback,
    required this.dietPreferenceCallback,
    required this.cookingSkillRatingCallback,
    required this.travelFrequencyCallback,
    this.showHeading = true,
    required this.initialData,
  });

  @override
  _Step2Content2State createState() => _Step2Content2State();
}

class _Step2Content2State extends State<Step2Content2> {
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
              label: '6. What is your gender?',
              options: ['Male', 'Female', 'Other'],
              onChanged: widget.genderCallback,
              initialValue: widget.initialData['gender'] == null ||
                      widget.initialData['gender'] == ''
                  ? 'Select Gender'
                  : widget.initialData['gender'],
            ),
            SizedBox(height: 20),
            CustomRadioGroup(
              label: '7. What is your personality like?',
              initialValue: widget.initialData['personality'] == null ||
                      widget.initialData['personality'] == ''
                  ? 'Select Personality'
                  : widget.initialData['personality'],
              options: [
                'Extroverted',
                'Introverted',
                'Ambivert',
                // 'A mix of both',
                // 'Prefer not to say'
              ],
              onChanged: widget.personalityCallback,
            ),
            SizedBox(height: 20),
            CustomChipGroup(
              label: '8. What are your hobbies and interests?',
              initialValues: widget.initialData['interests'] == null
                  ? []
                  : List<String>.from(widget.initialData['interests']),
              options: [
                'Movies',
                'NBA',
                'Soccer',
                'TV Shows',
                'Traveling',
                'Anime',
                'Gaming',
                'Cooking',
                'Reading'
              ],
              onChanged: widget.interestsCallback,
            ),
            // SizedBox(height: 20),
            // CustomRadioGroup(
            //   label: '9. What is your diet preference?',
            //   options: ['Vegetarian', 'Non-vegetarian', 'Vegan'],
            //   onChanged: widget.dietPreferenceCallback,
            // ),
            // SizedBox(height: 20),
            // CustomSliderGroup(
            //   label: 'Rate your cooking skills on a scale of 1 to 10.',
            //   initialValue: 4,
            //   min: 1,
            //   max: 10,
            //   onChanged: widget.cookingSkillRatingCallback,
            // ),
            // SizedBox(height: 20),
            // CustomRadioGroup(
            //   label: '12. How often do you travel?',
            //   options: ['Sometimes', 'More often', 'Never'],
            //   onChanged: widget.travelFrequencyCallback,
            // ),
          ],
        ),
      ),
    );
  }
}

class Step3Content2 extends StatefulWidget {
  final TextEditingController ideaName;
  final TextEditingController onliner;
  final TextEditingController weburl;
  final TextEditingController domainIdea;
  final TextEditingController workingOn;
  final TextEditingController connectWIth;
  final bool showHeading;
  final Map<String, dynamic> initialData;
  const Step3Content2({
    required this.ideaName,
    required this.onliner,
    required this.weburl,
    required this.domainIdea,
    required this.workingOn,
    required this.connectWIth,
    this.showHeading = true,
    required this.initialData,
  });

  @override
  _Step3Content2State createState() => _Step3Content2State();
}

class _Step3Content2State extends State<Step3Content2> {
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
            Text('10. What is the name of your idea',
                style: AppTextStyle.semibold16),
            SizedBox(height: 8),
            TextFeildStyle(
              hintText: '',
              fillColor: Color(0xffFAFBFB),
              validation: FormValidators.validateFirstName,
              textAlignVertical: TextAlignVertical.center,
              controller: widget.ideaName,
              onChanged: (value) {},
              initialValue: widget.initialData['idea_name'] == null ||
                      widget.initialData['idea_name'] == ''
                  ? 'Enter Idea Name'
                  : widget.initialData['idea_name'],
            ),
            SizedBox(height: 20),
            Text('11. Describe it in one line', style: AppTextStyle.semibold16),
            SizedBox(height: 8),
            TextFeildStyle(
              initialValue: widget.initialData['idea_in_oneline'] == null ||
                      widget.initialData['idea_in_oneline'] == ''
                  ? 'Enter One Liner'
                  : widget.initialData['idea_in_oneline'],
              hintText: '',
              fillColor: Color(0xffFAFBFB),
              validation: FormValidators.validateFirstName,
              textAlignVertical: TextAlignVertical.center,
              controller: widget.onliner,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            Text('12. Website url', style: AppTextStyle.semibold16),
            SizedBox(height: 8),
            TextFeildStyle(
              initialValue: widget.initialData['website_url'] == null ||
                      widget.initialData['website_url'] == ''
                  ? 'Enter Website URL'
                  : widget.initialData['website_url'],
              hintText: '',
              fillColor: Color(0xffFAFBFB),
              validation: FormValidators.validateFirstName,
              textAlignVertical: TextAlignVertical.center,
              controller: widget.weburl,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              initialValue: widget.initialData['domainIdea'] == null ||
                      widget.initialData['domainIdea'] == ''
                  ? 'Select career domain'
                  : widget.initialData['domainIdea'],
              label: '13. What domain is your idea in?',
              controller: widget.domainIdea,
              items: [
                'Select career domain',
                '🔒 Cybersecurity',
                '☁️ SaaS (Software as a Service)',
                '🌿 Green Technology',
                '🍴 Food and Beverage',
                '🚚 Logistics and Supply Chain',
                '🎬 Entertainment',
                '🧑‍💼 HR and Recruitment',
                '📱 Mobile Applications',
                '🚗 Automotive',
                '🌐 IoT (Internet of Things)',
                '⚖️ Legal Tech',
                '📋 Insurtech',
                '🤖 Robotics',
                '⌚ Wearable Technology',
                '❤️ Non-Profit and Social Impact'
              ],
              // initialValue: 'Select career domain',
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: '14. What are you working on?',
              controller: widget.workingOn,
              items: [
                'Select career domain',
                '🎨 Working on a creative endeavor',
                '💻 Developing a tech product',
                '📚 Writing a book or creating content',
                '🎨 Designing digital art or graphics',
                '👨‍👩‍👧‍👦 Managing a community or online group',
                '🎮 Creating a game or immersive experience',
                'Other'
              ],
              initialValue: widget.initialData['workingOn'] == null ||
                      widget.initialData['workingOn'] == ''
                  ? 'Select career domain'
                  : widget.initialData['workingOn'],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: '15. Who do you want to connect with?',
              controller: widget.connectWIth,
              items: [
                'Select career domain',
                '💼 Potential business partners',
                '📈 Investors and venture capitalists',
                '⚙️ Technical co-founders or developers',
                '📣 Marketing and social media experts',
                '🎨 Designers and creatives',
                '🧠 Mentors and advisors',
                '🚀 Sales and business development pros',
                '✨ Influencers and content creators',
                '💡 Peer innovators and cultivators',
                '💬 Those ready to give feedback and insights',
                'Other'
              ],
              initialValue: widget.initialData['connectWIth'] == null ||
                      widget.initialData['connectWIth'] == ''
                  ? 'Select career domain'
                  : widget.initialData['connectWIth'],
            ),
          ],
        ),
      ),
    );
  }
}
