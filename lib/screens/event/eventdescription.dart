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
                  Expanded(
                    child: Text('Friday, August 16 7:00 PM - 9:00 PM EDT',
                        style: AppTextStyle.semibold14
                            .copyWith(color: primaryColor)),
                  ),
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
                  Text('Shashank',
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
                          '''I'm thrilled to announce the upcoming launch event for Tribzy, my AI-powered roommate matching platform. To make this event even more exciting, I’m bringing my other innovative ventures as co-sponsors:

​Rydify: Discover how we're revolutionizing communal ride-sharing.

​Synq space: Experience seamless cross-platform contact sharing.

​Join us for an exciting pool party hosted by Tribzy to celebrate the move-in day at BLVD Apartments! This event is designed to help new residents connect and get to know each other while having fun in the sun.

​What's in Store:

​Engaging Activities: Icebreakers, pool games, and team activities.

​Special Offers: Exclusive deals for BLVD residents who sign up for Tribzy.

​Exciting Giveaways: Prizes and surprises for attendees.

​Refreshments: Complimentary snacks and drinks to keep you refreshed.

​Why Attend:

​Meet your new neighbors and make new friends.

​Discover how Tribzy can enhance your living experience by helping you find compatible roommates and join vibrant communities.

​Learn about Rydify, Gnapika and Synq Space, and how these ventures can benefit you.

​Enjoy a fun-filled evening with great company and lots of entertainment. ''',
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
