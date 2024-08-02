import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tribzyco/Widget/appbar.dart';
import 'package:tribzyco/Widget/communitycard.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/main.dart';
import 'package:tribzyco/screens/event/createevent.dart';
import 'package:tribzyco/screens/event/eventcard.dart';
import 'package:tribzyco/screens/event/eventdescription.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/constants.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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
                'Community events',
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      nextPage(context, EventDescriptionScreen());
                    },
                    child: EventCard(
                      // rating: 4.2,
                      // type: 'Private',
                      category: 'Yoga Class',
                      name: 'Sun, Jul 14 | 10:00 AM EDT',
                      address: '123 Main St., Downtown Area',
                      imageUrl: 'images/Mask group.png', dateTime: '',
                    ),
                  );
                },
              ),
              // Text("data"),
              GestureDetector(
                onTap: () {
                  nextPage(context, CreateEventScreen());
                },
                child: Text.rich(
                  TextSpan(
                    text: "Want to post an event? ",
                    style: AppTextStyle.mediumgrey14,
                    children: [
                      TextSpan(
                        text: 'Add it here!',
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ),

              // CommunityCard(
              //   name: 'Stoneridge',
              //   address: '3800 SW 34th St, Gainesville, FL 32608',
              //   imageUrl: 'assets/stoneridge.jpg',
              // ),
              SizedBox(height: 46),
              // Text("Texttttttttt"),
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
