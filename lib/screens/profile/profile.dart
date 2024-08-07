import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/progressHud.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/screens/profile/manageprofile.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CompleteProfileController controller =
      Get.put(CompleteProfileController());

  // String username = 'Username';
  String profilePic = '';

  Future<void> updateUserProfile({
    required String field,
    required dynamic value,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        controller.isLoading.value = true;
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          field: value,
        });
        print('Profile updated successfully');
      } catch (e) {
        print('Failed to update profile: $e');
      } finally {
        controller.isLoading.value = false;
      }
    }
  }

  Future<void> updateStep1() async {
    await updateUserProfile(
        field: 'country', value: controller.countryController.text);
    await updateUserProfile(
        field: 'state', value: controller.stateController.text);
    await updateUserProfile(field: 'age', value: controller.ageController.text);
    await updateUserProfile(
        field: 'pet_friendly', value: controller.petFriendly.value);
    await updateUserProfile(
        field: 'sleep_pattern', value: controller.sleepPattern.value);
    await updateUserProfile(
        field: 'smoke_or_drink', value: controller.smokeOrDrink.value);
  }

  Future<void> updateStep2() async {
    await updateUserProfile(field: 'gender', value: controller.gender.value);
    await updateUserProfile(
        field: 'personality', value: controller.personality.value);
    await updateUserProfile(
        field: 'interests', value: controller.interests.value);
    await updateUserProfile(
        field: 'diet_preference', value: controller.dietPreference.value);
    await updateUserProfile(
        field: 'rating_cookingskill',
        value: controller.cookingSkillRating.value);
    await updateUserProfile(
        field: 'travel', value: controller.travelFrequency.value);
  }

  Future<void> updateStep3() async {
    await updateUserProfile(
        field: 'major', value: controller.majorController.text);
    await updateUserProfile(
        field: 'degree_type', value: controller.degreeTypeController.text);
    await updateUserProfile(
        field: 'career_path', value: controller.careerPathController.text);
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user :: $user");
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();
      print("userData :: ${userData.data()}");

      if (userData.exists) {
        controller.countryController.text =
            userData['country']?.toString() ?? 'N/A';
        controller.stateController.text =
            userData['state']?.toString() ?? 'N/A';
        controller.ageController.text = userData['age']?.toString() ?? 'N/A';
        controller.majorController.text =
            userData['major']?.toString() ?? 'N/A';
        controller.degreeTypeController.text =
            userData['degree_type']?.toString() ?? 'N/A';
        controller.careerPathController.text =
            userData['career_path']?.toString() ?? 'N/A';
        controller.gender.value = userData['gender']?.toString() ?? 'N/A';
        controller.personality.value =
            userData['personality']?.toString() ?? 'N/A';
        controller.interests.value = userData['interests'] != null
            ? List<String>.from(userData['interests'])
            : [];
        controller.dietPreference.value =
            userData['diet_preference']?.toString() ?? 'N/A';
        controller.petFriendly.value = userData['pet_friendly'] ?? true;
        controller.cookingSkillRating.value =
            userData['rating_cookingskill']?.toString() ?? 'N/A';
        controller.sleepPattern.value =
            userData['sleep_pattern']?.toString() ?? 'N/A';
        controller.smokeOrDrink.value =
            userData['smoke_or_drink']?.toString() ?? 'N/A';
        controller.travelFrequency.value =
            userData['travel']?.toString() ?? 'N/A';
        controller.username.value =
            userData['username']?.toString() ?? "Not Available";
        controller.profilePic.value = userData['profile_pic']?.toString() ?? "";
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: AppTextStyle.semibold18,
                          ),
                          SvgPicture.asset('icons/bell.svg'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                controller.profilePic.value.isNotEmpty
                                    ? NetworkImage(controller.profilePic.value)
                                        as ImageProvider<Object>?
                                    : AssetImage('images/Group 427323160.png'),
                          ),
                          2.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.username.value,
                                  style: AppTextStyle.bold20,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  FirebaseAuth.instance.currentUser?.email ??
                                      "Not Available",
                                  style: AppTextStyle.medium14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Color(0xff8B8F94),
                        ),
                      ),
                    ],
                  ),
                ),
                ProfileListItem(
                  iconPath: 'icons/profilescreen/profile_personal.svg',
                  title: 'Personal',
                  onTap: () {
                    nextPage(context, ManageProfile());
                  },
                ),
                ProfileListItem(
                  iconPath: 'icons/profilescreen/profile_habits.svg',
                  title: 'Habits and Preferences',
                  onTap: () {
                    nextPage(
                      context,
                      Scaffold(
                        backgroundColor: bgColor,
                        body: ProgressHUD(
                          isLoading: controller.isLoading.value,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40.0, horizontal: 18),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Text(
                                        'Habits and Preferences',
                                        style: AppTextStyle.semibold18,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Step1Content(
                                    showHeading: false,
                                    countryController:
                                        controller.countryController,
                                    stateController: controller.stateController,
                                    ageController: controller.ageController,
                                    petFriendlyCallback: (value) =>
                                        controller.petFriendly.value = value,
                                    sleepPatternCallback: (value) =>
                                        controller.sleepPattern.value = value,
                                    smokeOrDrinkCallback: (value) =>
                                        controller.smokeOrDrink.value = value,
                                    initialData: controller.initialDataStep1,
                                  ),
                                  2.ph,
                                  CustomButton(
                                    text: 'Save',
                                    onPressed: () async {
                                      try {
                                        await updateStep1();
                                        showSucessMessage(context,
                                            'Profile updated successfully');
                                      } catch (e) {
                                        showErrorMessage(context,
                                            'Error updating profile: $e');

                                        print('Error updating profile: $e');
                                      }

                                      nextPage(
                                          context,
                                          MainScreen(
                                            initialIndex: 3,
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ProfileListItem(
                  iconPath: 'icons/profilescreen/profile_characteristic.svg',
                  title: 'Characteristics and Interests',
                  onTap: () {
                    nextPage(
                      context,
                      Scaffold(
                        backgroundColor: bgColor,
                        body: ProgressHUD(
                          isLoading: controller.isLoading.value,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40.0, horizontal: 18),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Text(
                                        'Characteristics and Interests',
                                        style: AppTextStyle.semibold18,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Step2Content(
                                    showHeading: false,
                                    genderCallback: (value) =>
                                        controller.gender.value = value,
                                    personalityCallback: (value) =>
                                        controller.personality.value = value,
                                    interestsCallback: (value) =>
                                        controller.interests.value = value,
                                    dietPreferenceCallback: (value) =>
                                        controller.dietPreference.value = value,
                                    cookingSkillRatingCallback: (value) =>
                                        controller.cookingSkillRating.value =
                                            value.toString(),
                                    travelFrequencyCallback: (value) =>
                                        controller.travelFrequency.value =
                                            value,
                                    initialData: controller.initialDataStep2,
                                  ),
                                  2.ph,
                                  CustomButton(
                                    text: 'Save',
                                    onPressed: () async {
                                      try {
                                        await updateStep2();
                                        showSucessMessage(context,
                                            'Profile updated successfully');
                                      } catch (e) {
                                        showErrorMessage(context,
                                            'Error updating profile: $e');

                                        print('Error updating profile: $e');
                                      }
                                      nextPage(
                                          context,
                                          MainScreen(
                                            initialIndex: 3,
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ProfileListItem(
                  iconPath: 'icons/profilescreen/profile_academic.svg',
                  title: 'Academic and Background',
                  onTap: () {
                    nextPage(
                      context,
                      Scaffold(
                        backgroundColor: bgColor,
                        body: ProgressHUD(
                          isLoading: controller.isLoading.value,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 40.0, horizontal: 18),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Text(
                                        'Academic and Background',
                                        style: AppTextStyle.semibold18,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Step3Content(
                                    majorController: controller.majorController,
                                    degreeTypeController:
                                        controller.degreeTypeController,
                                    careerPathController:
                                        controller.careerPathController,
                                    initialData: controller.initialDataStep3,
                                  ),
                                  2.ph,
                                  CustomButton(
                                    text: 'Save',
                                    onPressed: () async {
                                      try {
                                        await updateStep3();
                                        showSucessMessage(context,
                                            'Profile updated successfully');
                                      } catch (e) {
                                        showErrorMessage(context,
                                            'Error updating profile: $e');
                                        print('Error updating profile: $e');
                                      }
                                      nextPage(
                                          context,
                                          MainScreen(
                                            initialIndex: 3,
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ProfileListItem(
                  iconPath: 'icons/profilescreen/profile_terms.svg',
                  title: 'Terms',
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: SvgPicture.asset(
                        'icons/profilescreen/profile_logout.svg'),
                    title: Text(
                      'Log Out',
                      style: AppTextStyle.semibold16,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const ProfileListItem({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: SvgPicture.asset(iconPath),
        title: Text(
          title,
          style: AppTextStyle.semibold16,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
