import 'package:flutter/material.dart';
import 'package:tribzyco/utilities/colors.dart';
import 'package:tribzyco/utilities/textstyles.dart';

class CustomDropdownField extends StatefulWidget {
  final bool withoutLabel;
  final String label;
  final TextEditingController controller;
  final List<String> items;

  CustomDropdownField({
    this.withoutLabel = false,
    required this.label,
    required this.controller,
    required this.items,
  });

  @override
  _CustomDropdownFieldState createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.withoutLabel)
          Text(widget.label, style: AppTextStyle.semibold16),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedItem,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: widget.withoutLabel ? greyColor : lightGreyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: widget.withoutLabel ? greyColor : lightGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: widget.withoutLabel ? greyColor : lightGreyColor),
            ),
            filled: true,
            fillColor: Color(0xffFAFBFB),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: greyColor,
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item,
                  style: TextStyle(
                      color: widget.withoutLabel ? blackColor : greyColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedItem = newValue!;
              widget.controller.text = newValue;
            });
          },
        ),
      ],
    );
  }
}
