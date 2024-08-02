import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class EventDescriptionScreen extends StatefulWidget {
  @override
  _EventDescriptionScreenState createState() => _EventDescriptionScreenState();
}

class _EventDescriptionScreenState extends State<EventDescriptionScreen> {
  bool isInterested = false;

  void handleInterest() {
    setState(() {
      isInterested = !isInterested;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SvgPicture.asset(
              'images/part pic.svg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Date | Time',
            style: AppTextStyle.semibold14,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEAE2FC),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset('icons/date time.svg'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Sun, July 14 | 10:00 AM EDT',
                      style: AppTextStyle.semibold14
                          .copyWith(color: primaryColor)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Place',
            style: AppTextStyle.semibold14,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEAE2FC),
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20),
                      child: SvgPicture.asset('icons/place.svg'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Pool',
                      style: AppTextStyle.semibold14
                          .copyWith(color: primaryColor)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Host',
            style: AppTextStyle.semibold14,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEAE2FC),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.asset('icons/host.svg'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Sammy',
                      style: AppTextStyle.semibold14
                          .copyWith(color: primaryColor)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Description',
            style: AppTextStyle.semibold14,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Hey everyone! I’m hosting a swimming pool party at my place, and I’d love for you to join in on the fun! We’ll be diving into a day full of sun, laughter, and good times by the pool. Expect refreshing swims, exciting water games, and a variety of delicious snacks and drinks. Whether you want to lounge poolside or get active with some fun pool activities, there’s something for everyone. Don’t forget to bring your swimsuit and your best party spirit.',
                          style: AppTextStyle.semibold14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text('24 Attendees', style: AppTextStyle.semibold14),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/attendee1.jpg'), // Change to the actual image asset path
                radius: 20,
              ),
              SizedBox(width: 8),
              SvgPicture.asset('icons/attendies/Ellipse 220.svg'),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/attendee3.jpg'), // Change to the actual image asset path
                radius: 20,
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/attendee4.jpg'), // Change to the actual image asset path
                radius: 20,
              ),
              SizedBox(width: 8),
              SvgPicture.asset('icons/attendies/Ellipse 221.svg'),
            ],
          ),
          3.ph,
          CustomButton(text: 'I’m Interested', onPressed: () {}),
          7.ph,
        ],
      ),
    );
  }
}
