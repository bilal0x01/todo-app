import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required this.selectedPage,
    required this.onTapAction,
    required this.buttonText,
    required this.textColor,
    required this.backgroundColor,
  });

  final int selectedPage;
  final VoidCallback onTapAction;
  final String buttonText;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: AppColors.subtleColor,
        onTap: onTapAction,
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
