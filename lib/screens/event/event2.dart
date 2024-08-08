import 'package:flutter/material.dart';
import 'package:tribzyco/Widget/appbar.dart';



class EventPage2 extends StatefulWidget {
  const EventPage2({super.key});

  @override
  State<EventPage2> createState() => _EventPage2State();
}

class _EventPage2State extends State<EventPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 120),
            child: Center(
              child: Text(
                'Coming Soon...',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}
