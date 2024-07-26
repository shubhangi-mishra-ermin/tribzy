import 'package:flutter/material.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CustomRadioGroup extends StatelessWidget {
  final String label;
  final List<String> options;

  CustomRadioGroup({
    required this.label,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.semibold16),
        SizedBox(height: 8),
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(
                option,
                style: AppTextStyle.semibold16
                    .copyWith(fontWeight: FontWeight.w300, color: greyColor),
              ),
              // fillColor: primaryColor,
              activeColor: primaryColor,
              value: option,
              groupValue:
                  options.first, // Handle group value in state management
              onChanged: (String? value) {},
            );
          }).toList(),
        ),
      ],
    );
  }
}
