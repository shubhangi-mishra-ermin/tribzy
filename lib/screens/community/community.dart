import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/screens/community/communitycontroller.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'package:tribzyco/screens/navigationpage.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunityDetails(
                              communityName: community['name'],
                              // communityData: community, // Pass the community data here
                            ),
                          ),
                        );
                      },
                      child: CommunityCard(
                        rating: community['rating'],
                        type: community['type'],
                        category: community['furnishing'],
                        name: community['name'],
                        address:
                            'Distance from UF: ${community['distance_from_UF']}',
                        imageUrl: community['image_url'],
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
              //       MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)),
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
