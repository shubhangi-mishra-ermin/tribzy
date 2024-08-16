import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:tribzyco/screens/navigationpage.dart';

class CommunityPage2 extends StatefulWidget {
  const CommunityPage2({super.key});

  @override
  State<CommunityPage2> createState() => _CommunityPage2State();
}

class _CommunityPage2State extends State<CommunityPage2> {
  final CommunityController _communityController =
      Get.put(CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Communities',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Obx(() {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _communityController.communityList.length,
                  itemBuilder: (context, index) {
                    final community = _communityController.communityList[index];
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          // Only for the first CommunityCard
                          if (FirebaseAuth.instance.currentUser?.uid != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommunityDetails(
                                  communityName: community['name'],
                                  // communityData: community, // Pass the community data here if needed
                                ),
                              ),
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
                        } else {
                          // Optionally, show a dialog or perform another action for non-first items
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CreateProfileDialog(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  // Optionally navigate to a different page or take other actions
                                },
                                title: 'Access Restricted',
                                description:
                                    'You can only view the details for the first community card.',
                                imagePath: 'icons/restricted.svg',
                                buttonText: 'OK',
                              );
                            },
                          );
                        }
                      },
                      child: CommunityCard2(
                        category: 'central location, modern, business-friendly',
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
              // CustomButton(
              //   text: 'View more Communities',
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => MainScreen(initialIndex: 2)),
              //     );
              //   },
              // ),
              // SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
