import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/createprofiledialog.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class HomiesPage extends StatefulWidget {
  const HomiesPage({super.key});

  @override
  State<HomiesPage> createState() => _HomiesPageState();
}

class _HomiesPageState extends State<HomiesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserStatus();
    });
  }

  void _checkUserStatus() {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
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
            buttonText: 'Log In',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: FirebaseAuth.instance.currentUser?.uid == null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 120),
                child: Center(
                  child: Text(
                    'Please Log in first',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Homies',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SvgPicture.asset(
                          'icons/message_icon.svg',
                          width: 20,
                        )
                      ],
                    ),
                    2.ph,
                    HomieCard(),
                    10.ph
                  ],
                )),
      ),
    );
  }
}

class HomieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  'images/image 133.png',
                  // height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 16,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.clear, color: primaryColor),
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Farza',
                  style: AppTextStyle.bold20,
                ),
                SizedBox(height: 4),
                Text(
                  'Founder',
                  style: AppTextStyle.semibold16,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'icons/country_icon.svg',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Pakistan',
                          style: AppTextStyle.mediumgrey14,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                    SvgPicture.asset(
                      'icons/linkedinIcon.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('icons/buildspace.svg'),
                        SizedBox(width: 8),
                        Text(
                          'Buildspace',
                          style: AppTextStyle.semibold16,
                        ),
                      ],
                    ),
                    Text(
                      'Platform for Building your Ideas',
                      style: AppTextStyle.mediumgrey14,
                    ),
                    Text(
                      'Buildspace.com',
                      style: AppTextStyle.semiboldpurple12,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset('icons/hobbies.svg'),
                    1.pw,
                    Text(
                      'Hobbies and interests',
                      style: AppTextStyle.semibold16,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    InterestChip(label: 'Movies'),
                    InterestChip(label: 'Anime'),
                    InterestChip(label: 'Soccer'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InterestChip extends StatelessWidget {
  final String label;

  InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(color: primaryColor),
      ),
      labelStyle: TextStyle(color: primaryColor),
    );
  }
}
