import 'package:flutter/material.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/colors.dart'; // Ensure this file contains the necessary color definitions

class CustomChipGroup extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(List<String>) onChanged;

  CustomChipGroup({
    required this.label,
    required this.options,
    required this.onChanged,
  });

  @override
  _CustomChipGroupState createState() => _CustomChipGroupState();
}

class _CustomChipGroupState extends State<CustomChipGroup> {
  late List<bool> _selectedOptions;
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<bool>.generate(widget.options.length, (_) => false);
    _selectedValues = [];
  }

  void _updateSelectedValues() {
    _selectedValues = [];
    for (int i = 0; i < _selectedOptions.length; i++) {
      if (_selectedOptions[i]) {
        _selectedValues.add(widget.options[i]);
      }
    }
    widget.onChanged(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyle.semibold16,
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(widget.options.length, (int index) {
            return ChoiceChip(
              label: Text(
                widget.options[index],
                style: _selectedOptions[index]
                    ? AppTextStyle.medium14.copyWith(color: primaryColor)
                    : AppTextStyle.medium14,
              ),
              selected: _selectedOptions[index],
              onSelected: (bool selected) {
                setState(() {
                  _selectedOptions[index] = selected;
                  _updateSelectedValues();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(
                  color: _selectedOptions[index] ? primaryColor : Colors.grey,
                ),
              ),
              backgroundColor: Colors.white,
              selectedColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(horizontal: 6),
              showCheckmark: false,
            );
          }),
        ),
      ],
    );
  }
}
