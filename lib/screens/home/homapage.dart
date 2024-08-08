import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/community/communitycontroller.dart';
import 'package:tribzyco/screens/community/communitydetails.dart';
import 'package:tribzyco/screens/community/community.dart';
import 'package:tribzyco/screens/home/homepage2.dart';
import 'package:tribzyco/screens/navigationpage.dart';
import 'package:tribzyco/utilities/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommunityController _communityController =
      Get.put(CommunityController());
  bool? isInSanFrancisco;
  @override
  void initState() {
    // TODO: implement initState
    isInSanFrancisco = prefs!.getBool('isInSanFrancisco');
    print("isInSanFrancisco :: $isInSanFrancisco");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isInSanFrancisco ?? false
        ? HomeScreen2()
        : Scaffold(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              onPressed: () {
                                nextPage(context, CommunityPage());
                              },
                              child: Text(
                                'View all',
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
                            itemCount:
                                _communityController.communityList.length < 3
                                    ? _communityController.communityList.length
                                    : 3,
                            itemBuilder: (context, index) {
                              final community =
                                  _communityController.communityList[index];
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
                        CustomButton(
                          text: 'View more Communities',
                          onPressed: () {
                            nextPage(
                                context,
                                MainScreen(
                                  initialIndex: 1,
                                ));
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
