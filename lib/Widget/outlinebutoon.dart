import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tribzyco/utilities/colors.dart';

class CustomOutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final String iconSvgPath;
  final double width;
  final double textSize;
  final Color borderColor;
  final Color textColor;

  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.iconSvgPath = '',
    this.width = double.infinity,
    this.textSize = 18,
    this.borderColor = primaryColor,
    this.textColor = primaryColor,
  }) : super(key: key);

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height / 16,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onHover: (isHovered) {
              setState(() {
                _isHovered = isHovered;
              });
            },
            borderRadius: BorderRadius.circular(6),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: widget.textSize,
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
