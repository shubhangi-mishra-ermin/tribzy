
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    Key? key,
    required this.iconPath,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(iconPath),
      onPressed: onPressed,
    );
  }
}