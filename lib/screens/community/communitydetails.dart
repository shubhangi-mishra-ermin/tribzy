import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CommunityDetails extends StatelessWidget {
  final String communityName; // Add this parameter

  const CommunityDetails({super.key, required this.communityName});

  @override
  Widget build(BuildContext context) {
    final CommunityDetailsController controller = Get.put(CommunityDetailsController(communityName: communityName));

    final Map<String, String> amenityIconMapping = {
      'bedroom': 'icons/bedroom.svg',
      'private': 'icons/room.svg',
      'furnished': 'icons/furnished.svg',
      'wifi': 'icons/wifi.svg',
      'parking': 'icons/parking.svg',
      'kitchen': 'icons/kitchen.svg',
      'washer': 'icons/washer.svg',
      'pet': 'icons/pet friendly.svg',
      'more': 'icons/more.svg',
    };
    String _getIconPathForAmenity(String amenity) {
      String lowerCaseAmenity = amenity.toLowerCase();
      for (var entry in amenityIconMapping.entries) {
        if (lowerCaseAmenity.contains(entry.key)) {
          return entry.value;
        }
      }
      return 'icons/more.svg';
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final communityData = controller.communityData;
        // final currentUserCredential = controller.currentUserCredential.value;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: [communityData['image_url']]
                    .map((url) => GestureDetector(
                          onTap: () {
                            // Handle tap if needed
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 4,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amenities',
                      style: AppTextStyle.semibold14
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 2,
                          runSpacing: 2,
                          children: List<String>.from(
                                  communityData['amenities'] ?? [])
                              .map<Widget>((amenity) {
                            final iconPath = _getIconPathForAmenity(amenity);
                            return AmenityCard(
                              icon: iconPath,
                              label: amenity,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LeaseDetail(
                            label: 'Lease Start',
                            value: communityData['lease_start'] ?? 'NA'),
                        LeaseDetail(
                            label: 'Lease End',
                            value: communityData['lease_end'] ?? 'NA'),
                        LeaseDetail(
                            label: 'Area',
                            value: communityData['area'] ?? 'NA'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description',
                      style: AppTextStyle.semibold14
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          communityData['description'] ??
                              'No Description Available',
                          style: AppTextStyle.medium14
                              .copyWith(color: Color(0xff8B8F94)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Floor Plan (Recommended)',
                      style: AppTextStyle.semibold14
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List<Map<String, dynamic>>.from(
                                communityData['floor_plans'] ?? [])
                            .map<Widget>((floorPlan) => FloorPlanCard(
                                  price: floorPlan['price'] ?? 'NA',
                                  details: floorPlan['type'] ?? 'NA',
                                  imagePath: 'images/floorplan.svg',
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Community Surroundings',
                      style: AppTextStyle.semibold14
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    CommunitySurroundings(
                      surroundings: List<Map<String, dynamic>>.from(
                          communityData['community_surroundings']?.entries.map(
                                  (e) =>
                                      {'label': e.key, 'distance': e.value}) ??
                              []),
                      busNumbers: List<Map<String, dynamic>>.from(
                              communityData['bus_numbers'] ?? [])
                          .map((bus) =>
                              '${bus['route']} to ${bus['destination']}')
                          .join(', '),
                    ),
                    SizedBox(height: 20),
                    // CustomButton(
                    //   text: 'Join Community',
                    //   onPressed: currentUserCredential != null
                    //       ? () {
                    //           showSucessMessage(context, "Successfully joined");
                    //           // Handle successful join
                    //         }
                    //       : () {
                    //           nextPage(context, LoginPage());
                    //         },
                    // ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class LeaseDetail extends StatelessWidget {
  final String label;
  final String value;

  const LeaseDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.semibold16),
        SizedBox(height: 8),
        Text(value,
            style: AppTextStyle.semibold16.copyWith(color: primaryColor)),
      ],
    );
  }
}

class AmenityCard extends StatelessWidget {
  final String icon;
  final String label;

  const AmenityCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyle.medium10,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CommunitySurroundings extends StatelessWidget {
  final List<Map<String, dynamic>> surroundings;
  final String busNumbers;

  CommunitySurroundings({required this.surroundings, required this.busNumbers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: surroundings
                  .map((item) => SurroundingDetail(
                        label: item['label'] ?? '',
                        distance: item['distance'] ?? '',
                      ))
                  .toList(),
            ),
          ),
        ),
        SizedBox(height: 16),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child:
                        Text('Bus Numbers', style: AppTextStyle.mediumgrey14)),
                Expanded(child: Text(busNumbers, style: AppTextStyle.medium14)),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FloorPlanCard extends StatelessWidget {
  final String price;
  final String details;
  final String imagePath;

  const FloorPlanCard(
      {required this.price, required this.details, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: SvgPicture.asset(imagePath,
                  height: 120, width: 200, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(price, style: AppTextStyle.medium14),
                  SizedBox(height: 4),
                  Text(details, style: AppTextStyle.medium14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SurroundingDetail extends StatelessWidget {
  final String label;
  final String distance;

  SurroundingDetail({required this.label, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyle.mediumgrey14),
        Text(distance, style: AppTextStyle.medium14),
      ],
    );
  }
}

class CommunityDetailsController extends GetxController {
  var communityData = {}.obs;
  var currentUserCredential = FirebaseAuth.instance.currentUser.obs;
  var isLoading = true.obs;
  final String communityName;

  CommunityDetailsController({required this.communityName});

  @override
  void onInit() {
    super.onInit();
    loadCommunityData();
  }
 Future<void> loadCommunityData() async {
    final String response =
        await rootBundle.loadString('data/community_info.json');
    final data = json.decode(response);

    communityData.value = data['community'];
    isLoading.value = false;
  }
  // void loadCommunityData() async {
  //   try {
  //     final jsonData = await rootBundle.loadString('data/community_list.json');
  //     final data = json.decode(jsonData);
  //     final community = data.firstWhere((element) => element['name'] == communityName, orElse: () => null);

  //     if (community != null) {
  //       communityData.value = community;
  //     } else {
  //       Get.snackbar('Error', 'Community not found');
  //     }
  //   } catch (e) {
  //     print('Error loading community data: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}