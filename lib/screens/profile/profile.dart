import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/authenctication/completeprofile/completeprofile.dart';
import 'package:tribzyco/globalvariables.dart';
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
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController degreeTypeController = TextEditingController();
  final TextEditingController careerPathController = TextEditingController();
  String username = '';
  String profilePic = '';
  var gender = ''.obs;
  var personality = ''.obs;
  var interests = <String>[].obs;
  var dietPreference = ''.obs;
  var petFriendly = true.obs;
  var cookingSkillRating = ''.obs;
  var sleepPattern = ''.obs;
  var smokeOrDrink = ''.obs;
  var travelFrequency = ''.obs;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }

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
        countryController.text = userData['country']?.toString() ?? 'N/A';
        stateController.text = userData['state']?.toString() ?? 'N/A';
        ageController.text = userData['age']?.toString() ?? 'N/A';
        majorController.text = userData['major']?.toString() ?? 'N/A';
        degreeTypeController.text =
            userData['degree_type']?.toString() ?? 'N/A';
        careerPathController.text =
            userData['career_path']?.toString() ?? 'N/A';
        gender.value = userData['gender']?.toString() ?? 'N/A';
        personality.value = userData['personality']?.toString() ?? 'N/A';
        interests.value = userData['interests'] != null
            ? List<String>.from(userData['interests'])
            : [];
        dietPreference.value = userData['diet_preference']?.toString() ?? 'N/A';
        petFriendly.value = userData['pet_friendly'] ?? true;
        cookingSkillRating.value =
            userData['rating_cookingskill']?.toString() ?? 'N/A';
        sleepPattern.value = userData['sleep_pattern']?.toString() ?? 'N/A';
        smokeOrDrink.value = userData['smoke_or_drink']?.toString() ?? 'N/A';
        travelFrequency.value = userData['travel']?.toString() ?? 'N/A';
        username = userData['username']?.toString() ?? "";
        profilePic = userData['profile_pic']?.toString() ?? "";
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
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
                        backgroundImage: profilePic != ''
                            ? NetworkImage(profilePic)
                            : AssetImage('images/Group 427323160.png'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FirebaseAuth.instance.currentUser?.displayName ??
                                "Not Available",
                            style: AppTextStyle.bold20,
                          ),
                          SizedBox(height: 5),
                          Text(
                            FirebaseAuth.instance.currentUser?.email ??
                                "Not Available",
                            style: AppTextStyle.medium14,
                          ),
                        ],
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
                    body: SingleChildScrollView(
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
                              countryController: countryController,
                              stateController: stateController,
                              ageController: ageController,
                              petFriendlyCallback: (value) =>
                                  petFriendly.value = value,
                              sleepPatternCallback: (value) =>
                                  sleepPattern.value = value,
                              smokeOrDrinkCallback: (value) =>
                                  smokeOrDrink.value = value,
                            ),
                            2.ph,
                            CustomButton(
                              text: 'Save',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
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
                    body: SingleChildScrollView(
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
                              genderCallback: (value) => gender.value = value,
                              personalityCallback: (value) =>
                                  personality.value = value,
                              interestsCallback: (value) =>
                                  interests.value = value,
                              dietPreferenceCallback: (value) =>
                                  dietPreference.value = value,
                              cookingSkillRatingCallback: (value) =>
                                  cookingSkillRating.value = value.toString(),
                              travelFrequencyCallback: (value) =>
                                  travelFrequency.value = value,
                            ),
                            2.ph,
                            CustomButton(
                              text: 'Save',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
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
                    body: SingleChildScrollView(
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
                              majorController: majorController,
                              degreeTypeController: degreeTypeController,
                              careerPathController: careerPathController,
                            ),
                            2.ph,
                            CustomButton(
                              text: 'Save',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading:
                    SvgPicture.asset('icons/profilescreen/profile_logout.svg'),
                title: Text(
                  'Log Out',
                  style: AppTextStyle.semibold16,
                ),
                // trailing: Icon(Icons.arrow_forward_ios),
                // onTap: onTap,
              ),
            )
          ],
        ),
      ),
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
