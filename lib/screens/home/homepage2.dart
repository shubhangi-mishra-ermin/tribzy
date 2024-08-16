import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/Widget/communitycard2.dart';
import 'package:tribzyco/Widget/createprofiledialog.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/community/communitycontroller.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/utilities/colors.dart';

class HomeScreen2 extends StatelessWidget {
  final CommunityController _communityController =
      Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xffE7DEFF),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Your New Home And Community Await With Tribzy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    SvgPicture.asset(
                      'images/groupimage_home.svg',
                      height: 200,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Near You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          nextPage(context, CommunityPage());
                        },
                        child: Text(
                          'All communities you visited',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Obx(() {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _communityController.communityList.length < 3
                          ? _communityController.communityList.length
                          : 3,
                      itemBuilder: (context, index) {
                        final community =
                            _communityController.communityList[index];
                        return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              // Only for the first CommunityCard
                              if (FirebaseAuth.instance.currentUser?.uid !=
                                  null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CreateProfileDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Optionally navigate to another page
                                        // nextPage(context, SomePage());
                                      },
                                      title: 'Welcome to Chapter SF',
                                      description:
                                          'To switch communities, go to Settings in the Profile section. Enjoy connecting with your new tribe!',
                                      imagePath: 'icons/welcomedialog.svg',
                                      buttonText: 'Continue',
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CreateProfileDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        nextPage(context, LoginPage());
                                      },
                                      title: 'Create Profile',
                                      description:
                                          'Create your profile to join the community, find compatible roommates, and enjoy the best experience.',
                                      imagePath: 'icons/createprofile.svg',
                                      buttonText: 'Continue',
                                    );
                                  },
                                );
                              }
                            }
                            // Optionally, handle taps for non-first items or do nothing
                          },
                          child: CommunityCard2(
                            category:
                                'central location, modern, business-friendly',
                            name: community['name'],
                            address:
                                '${community['distance_from_venue']} from venue',
                            imageUrl: community['image_url'],
                            type: 'jfs',
                            // distanceFromVenue: community['distance_from_venue'],
                          ),
                        );
                      },
                    );
                  }),
                  SizedBox(height: 16),

                  CustomButton(
                    text: 'View More',
                    onPressed: () {
                      // nextPage(context, CommunityPage());
                    },
                  ),
                  // SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
