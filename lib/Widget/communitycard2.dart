import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

import 'createprofiledialog.dart';

class CommunityCard2 extends StatefulWidget {
  final String name;
  final String address;
  final String imageUrl;
  final String type;
  final String category;
  // final double rating;

  CommunityCard2({
    required this.name,
    required this.address,
    required this.imageUrl,
    this.type = '',
    this.category = '',
    // this.rating = 0.0,
  });

  @override
  _CommunityCard2State createState() => _CommunityCard2State();
}

class _CommunityCard2State extends State<CommunityCard2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          children: [
            Image.network(
              widget.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey,
                  child: Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 40,
                  ),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTextStyle.semibold16,
                    ),
                    SizedBox(height: 4), //icons/address_icon.svg
                    Row(
                      children: [
                        SvgPicture.asset('icons/address_icon.svg'),
                        1.pw,
                        Expanded(
                          child: Text(
                            widget.address,
                            maxLines: widget.type != '' ? 1 : null,
                            overflow: widget.type != ''
                                ? TextOverflow.ellipsis
                                : null,
                            style: AppTextStyle.medium14
                                .copyWith(color: greyColor),
                          ),
                        )
                      ],
                    ),
                    if (widget.type != '') SizedBox(height: 8), //icons/tags.svg
                    Row(
                      children: [
                        SvgPicture.asset('icons/tags.svg'),
                        1.pw,
                        Expanded(
                          child: Text(
                            widget.category,
                            maxLines: widget.type != '' ? 1 : null,
                            overflow: widget.type != ''
                                ? TextOverflow.ellipsis
                                : null,
                            style: AppTextStyle.medium14
                                .copyWith(color: greyColor),
                          ),
                        ),
                      ],
                    ),
                    // if (widget.type != '')
                    //   InkWell(
                    // onTap: () {
                    //   if (FirebaseAuth.instance.currentUser?.uid != null) {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return CreateProfileDialog(
                    //           onPressed: () {
                    //             // Navigator.of(context).pop();
                    //             // nextPage(context, LoginPage());
                    //           },
                    //           title: 'Welcome to Chapter SF',
                    //           description:
                    //               'To switch communities, go to Settings in the Profile section. Enjoy connecting with your new tribe!',
                    //           imagePath: 'icons/welcomedialog.svg',
                    //           buttonText: 'Continue',
                    //         );
                    //       },
                    //     );
                    //   } else {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return CreateProfileDialog(
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //             nextPage(context, LoginPage());
                    //           },
                    //           title: 'Create Profile',
                    //           description:
                    //               'Create your profile to join the community, find compatible roommates, and enjoy the best experience.',
                    //           imagePath: 'icons/createprofile.svg',
                    //           buttonText: 'Continue',
                    //         );
                    //       },
                    //     );
                    //   }
                    // },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: primaryColor,
                    //         borderRadius: BorderRadius.circular(4.0),
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 9.0, vertical: 5),
                    //         child: Text(
                    //           'Join',
                    //           style: AppTextStyle.semibold14
                    //               .copyWith(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
