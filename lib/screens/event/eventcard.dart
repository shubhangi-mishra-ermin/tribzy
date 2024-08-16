import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class EventCard extends StatefulWidget {
  final String name;
  final String address;
  final String imageUrl;
  final String dateTime;
  final String category;

  EventCard({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.dateTime,
    required this.category,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
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
            Stack(
              children: [
                Image.network(
                  widget.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.favorite,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.more_vert, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.name,
                      style: AppTextStyle.semiboldpurple12,
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.category,
                      style: AppTextStyle.semibold16,
                    ),
                    SizedBox(height: 4),
                    Text(
                      maxLines: 1,
                      widget.address,
                      style: AppTextStyle.medium10.copyWith(color: greyColor),
                    ),
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
