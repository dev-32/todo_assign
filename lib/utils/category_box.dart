import 'package:flutter/material.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text_styles.dart';

class CategoryBoxUtil extends StatelessWidget {
  final Widget color;
  final String val;
  final bool isSelected;

  const CategoryBoxUtil(
      {super.key,
      required this.color,
      required this.val,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          foregroundDecoration: isSelected
              ? BoxDecoration(color: AppColors.primaryColor.withOpacity(0.4))
              : null,
          height: 64,
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
          child: color,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          val,
          style: AppTextStyles.normalWhiteText,
        ),
      ],
    );
  }
}
