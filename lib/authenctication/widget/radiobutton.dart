import 'package:flutter/material.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CustomRadioGroup extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(String) onChanged;

  const CustomRadioGroup({
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize the selected value with the first option or any other default value
    _selectedValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyle.semibold16),
        SizedBox(height: 8),
        Column(
          children: widget.options.map((option) {
            return RadioListTile<String>(
              title: Text(
                option,
                style: AppTextStyle.semibold16
                    .copyWith(fontWeight: FontWeight.w300, color: greyColor),
              ),
              activeColor: primaryColor,
              value: option,
              groupValue: _selectedValue,
              onChanged: (String? value) {
                setState(() {
                  _selectedValue = value;
                  widget.onChanged(value!);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
