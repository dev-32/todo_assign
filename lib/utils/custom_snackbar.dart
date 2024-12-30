import 'package:flutter/material.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({super.key, required this.stringContent});
  final String stringContent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: AppColors.grayColor),
      child: Text(
        stringContent,
        style: AppTextStyles.normalWhiteText,
      ),
    );
  }
}
