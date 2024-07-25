import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/customimagebutton.dart';
import 'package:tribzyco/Widget/customtextbutton.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Communities',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: TextStyle(color: primaryColor),
                          )),
                      // CustomTextButton(
                      //   text: 'View All',
                      //   onPressed: () {},
                      //   fontSize: 12,
                      // )
                    ],
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      nextPage(context, CommunityDetails());
                    },
                    child: CommunityCard(
                      name: 'BLVD Gainesville',
                      address: '4000 SW 37th Blvd, Gainesville, FL 32608',
                      imageUrl: 'images/commImg1.svg',
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      nextPage(context, CommunityDetails());
                    },
                    child: CommunityCard(
                      name: 'Stoneridge ',
                      address: '3800 SW 34th St, Gainesville, FL 32608',
                      imageUrl: 'images/commImg2.svg',
                    ),
                  ),
                  // CommunityCard(
                  //   name: 'Stoneridge',
                  //   address: '3800 SW 34th St, Gainesville, FL 32608',
                  //   imageUrl: 'assets/stoneridge.jpg',
                  // ),
                  SizedBox(height: 16),
                  CustomButton(
                      text: 'View more Communities',
                      onPressed: () {
                        // nextPage(context, CommunityPage());
                      }),
                  SizedBox(height: 56),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
