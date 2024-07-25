import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/Widget/customimagebutton.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SvgPicture.asset(
                'images/appLogo.svg',
              ),
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
              // ListView.builder(itemBuilder: itemBuilder)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      nextPage(context, CommunityDetails());
                    },
                    child: CommunityCard(
                      rating: 4.2,
                      type: 'Private',
                      category: 'Furnished',
                      name: 'BLVD Gainesville',
                      address: '4000 SW 37th Blvd, Gainesville, FL 32608',
                      imageUrl: 'images/commImg1.svg',
                    ),
                  );
                },
              ),

              // CommunityCard(
              //   name: 'Stoneridge',
              //   address: '3800 SW 34th St, Gainesville, FL 32608',
              //   imageUrl: 'assets/stoneridge.jpg',
              // ),
              SizedBox(height: 16),
              // CustomButton(
              //     text: 'View more Communities',
              //     onPressed: () {
              //       MainScreen(
              //         initialIndex: 2,
              //       );
              //     }),
              // SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
