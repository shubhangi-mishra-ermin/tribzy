import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CommunityDetails extends StatefulWidget {
  const CommunityDetails({super.key});

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {
  late String _currentUserCredential;

  @override
  void initState() {
    super.initState();
    _currentUserCredential = '';
    _getCurrentUserCredential();
  }

  Future<void> _getCurrentUserCredential() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUserCredential = user != null ? user.uid : '';
    });
  }

  final List<String> imageList = [
    'images/communityImg.svg',
    'images/communityImg.svg',
    'images/communityImg.svg',
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CarouselSlider(
                  items: imageList
                      .map((item) => GestureDetector(
                            onTap: () {
                              // nextPage(context, BannerPage());
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: SvgPicture.asset(
                                item,
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
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        _current = entry.key;
                      }),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : primaryColor)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
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
                        children: [
                          AmenityCard(
                              icon: 'icons/bedroom.svg', label: '4 bedrooms'),
                          AmenityCard(
                              icon: 'icons/room.svg',
                              label: 'Private\nBed, Bath'),
                          AmenityCard(
                              icon: 'icons/furnished.svg',
                              label: 'Fully\nFurnished'),
                          AmenityCard(
                              icon: 'icons/wifi.svg', label: 'Free Wifi'),
                          AmenityCard(
                              icon: 'icons/parking.svg', label: 'Parking'),
                          AmenityCard(
                              icon: 'icons/kitchen.svg', label: 'Kitchen'),
                          AmenityCard(
                              icon: 'icons/washer.svg', label: 'Washer'),
                          AmenityCard(
                              icon: 'icons/pet friendly.svg',
                              label: 'Pet Friendly'),
                          AmenityCard(icon: 'icons/more.svg', label: 'More'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LeaseDetail(label: 'Lease Start', value: '16 Aug 2024'),
                      LeaseDetail(label: 'Lease End', value: '31 July 2025'),
                      LeaseDetail(label: 'Area', value: '1250 Sqft'),
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
                        'Located just 2 miles from the University of Florida on Archer Road 5 minutes from Butler Town Center with popular retail and restaurants like Publix, Target, Trader Joes, and more - BLVD sets the stage for your ideal student lifestyle. After a quick 10-minute bus ride home, hit the books in your fully furnished and private bedroom at your study desk, or grab a free cup of coffee and settle in a private or group study room.',
                        style: AppTextStyle.medium14
                            .copyWith(color: Color(0xff8B8F94)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Floor Plan (Recommended)',
                      style: AppTextStyle.semibold14
                          .copyWith(fontWeight: FontWeight.bold)
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FloorPlanCard(
                            price: '\$510 Per Room',
                            details: '4 BR/3 BA - Platinum - Shared',
                            imagePath: 'images/floorplan.svg'),
                        FloorPlanCard(
                            price: '\$575 Per Room',
                            details: '4 BR/3 BA - Gold - Shared',
                            imagePath: 'images/floorplan.svg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Community Surroundings',
                    style: AppTextStyle.semibold14
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  CommunitySurroundings(),
                  2.ph,
                  CustomButton(
                    text: 'Join Community',
                    onPressed: _currentUserCredential.isNotEmpty
                        ? () {
                            showSucessMessage(context, "Successfully joined");
                            // Handle successful join
                          }
                        : () {
                            nextPage(context, LoginPage());
                          },
                  ),
                  8.ph
                ],
              ),
            ),
          ],
        ),
      ),
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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyle.medium10,

            // textDirection: TextD,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CommunitySurroundings extends StatelessWidget {
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
              children: [
                SurroundingDetail(
                    label: 'University of Florida', distance: '2.5 Miles'),
                SurroundingDetail(
                    label: 'Gainesville Airport', distance: '4.6 Miles'),
                SurroundingDetail(label: 'India Bazar', distance: '0.9 Miles'),
                SurroundingDetail(label: 'Walmart', distance: '1.2 Miles'),
                SurroundingDetail(label: 'Best Buy', distance: '0.8 Miles'),
                // SizedBox(height: 10),
              ],
            ),
          ),
        ),
        2.ph,
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bus Numbers', style: AppTextStyle.mediumgrey14),
                Text('12, 37 to the campus', style: AppTextStyle.medium14),
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
                  Text(price,
                      style: AppTextStyle.semibold16
                          .copyWith(fontWeight: FontWeight.bold)),
                  1.5.ph,
                  Text(details,
                      style: AppTextStyle.semiboldpurple12
                          .copyWith(color: blackColor)),
                  2.ph,
                  Row(
                    children: [
                      SvgPicture.asset('icons/grey_bedroom.svg'),
                      SizedBox(width: 4),
                      Text(
                        '4 Bedrooms',
                        style: AppTextStyle.mediumgrey14,
                      ),
                    ],
                  ),
                  1.ph,
                  Row(
                    children: [
                      SvgPicture.asset('icons/grey_area.svg'),
                      SizedBox(width: 4),
                      Text(
                        '0 Sq.Ft.',
                        style: AppTextStyle.mediumgrey14,
                      ),
                    ],
                  ),
                  1.ph,
                  Row(
                    children: [
                      SvgPicture.asset('icons/grey_bath.svg'),
                      SizedBox(width: 4),
                      Text(
                        '3 Bath',
                        style: AppTextStyle.mediumgrey14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SurroundingDetail extends StatelessWidget {
  final String label;
  final String distance;

  const SurroundingDetail({required this.label, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.mediumgrey14),
          Text(distance, style: AppTextStyle.medium14),
        ],
      ),
    );
  }
}
