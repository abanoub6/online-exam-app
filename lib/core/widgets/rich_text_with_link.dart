// lib/core/widgets/rich_text_with_link.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_exam_app_v/core/theme/app_text_styles.dart';

class RichTextWithLink extends StatelessWidget {
  final String normalText;
  final String linkText;
  final VoidCallback onLinkTap;
  final TextAlign? textAlign;
  final Color? linkTextColor;

  const RichTextWithLink({
    super.key,
    required this.normalText,
    required this.linkText,
    required this.onLinkTap,
    this.textAlign,
    this.linkTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: normalText,
            style: AppTextStyles.s14w400(Colors.grey.shade700),
          ),
          TextSpan(
            text: linkText,
            style: AppTextStyles.s14w600(linkTextColor),
            recognizer: TapGestureRecognizer()..onTap = onLinkTap,
          ),
        ],
      ),
    );
  }
}
