import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/Widget/custombutton.dart';
import 'package:tribzyco/authenctication/loginpage.dart';
import 'package:tribzyco/globalvariables.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CreateProfileDialog extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;
  final String buttonText;
  final VoidCallback onPressed; 

  const CreateProfileDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed, 
  }) : super(key: key);

  @override
  _CreateProfileDialogState createState() => _CreateProfileDialogState();
}

class _CreateProfileDialogState extends State<CreateProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 26),
          SvgPicture.asset(widget.imagePath),
          SizedBox(height: 16),
          Text(
            widget.title,
            style: AppTextStyle.bold24.copyWith(color: blackColor),
          ),
          SizedBox(height: 12),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: AppTextStyle.mediumgrey14,
          ),
          SizedBox(height: 46),
          CustomButton(
            text: widget.buttonText,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onPressed(); 
            },
          )
        ],
      ),
    );
  }
}
