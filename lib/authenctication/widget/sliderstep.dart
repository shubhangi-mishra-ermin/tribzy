import 'package:flutter/material.dart';
import 'package:tribzyco/utilities/textstyles.dart';
import 'package:tribzyco/utilities/colors.dart'; // Ensure this file contains the necessary color definitions

class CustomSliderGroup extends StatefulWidget {
  final String label;
  final double initialValue;
  final double min;
  final double max;
  final Function(double) onChanged;

  CustomSliderGroup({
    required this.label,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  _CustomSliderGroupState createState() => _CustomSliderGroupState();
}

class _CustomSliderGroupState extends State<CustomSliderGroup> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyle.semibold16),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primaryColor,
            inactiveTrackColor: Colors.grey,
            trackHeight: 4.0,
            thumbShape: CustomSliderThumbRect(
              thumbHeight: 30,
              thumbWidth: 50,
              min: widget.min,
              max: widget.max,
            ),
            overlayColor: primaryColor.withAlpha(32),
            thumbColor: primaryColor,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
          ),
          child: Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            divisions: (widget.max - widget.min).toInt(),
            onChanged: (double newValue) {
              setState(() {
                _currentValue = newValue;
                widget.onChanged(_currentValue);
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                List.generate((widget.max - widget.min).toInt() + 1, (index) {
              return Text(
                '${(widget.min + index).toInt()}',
                style: AppTextStyle.medium14,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbHeight;
  final double thumbWidth;
  final double min;
  final double max;

  const CustomSliderThumbRect({
    required this.thumbHeight,
    required this.thumbWidth,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(thumbRect, Radius.circular(8)),
      paint,
    );

    final TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      text: '${getValue(value)}',
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: textDirection,
    );

    tp.layout();
    tp.paint(
      canvas,
      Offset(
        thumbRect.center.dx - (tp.width / 2),
        thumbRect.center.dy - (tp.height / 2),
      ),
    );
  }

  String getValue(double value) {
    return (min + ((max - min) * value)).round().toString();
  }
}
