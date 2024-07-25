import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CommunityCard extends StatefulWidget {
  final String name;
  final String address;
  final String imageUrl;
  final String type;
  final String category;
  final double rating;

  CommunityCard({
    required this.name,
    required this.address,
    required this.imageUrl,
    this.type = '',
    this.category = '',
    this.rating = 0.0,
  });

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
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
            SvgPicture.asset(
              widget.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
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
                    SizedBox(height: 4),
                    Text(
                      widget.address,
                      maxLines: widget.type != '' ? 1 : null,
                      style: AppTextStyle.medium14.copyWith(color: greyColor),
                    ),
                    SizedBox(height: 8),
                    if (widget.type != '')
                      Text(
                        '${widget.type} | ${widget.category}',
                        style: AppTextStyle.medium14.copyWith(color: greyColor),
                      ),
                    SizedBox(height: 8),
                    widget.rating == 0.0
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              StarRating(rating: widget.rating),
                              SizedBox(width: 8),
                              Text(
                                widget.rating.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: primaryColor, size: 20);
        } else if (index < rating && index + 1 > rating) {
          return Icon(Icons.star_half, color: primaryColor, size: 20);
        } else {
          return Icon(Icons.star_border, color: primaryColor, size: 20);
        }
      }),
    );
  }
}
