import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/icons.dart';
import 'package:todo_assign/constant/text_styles.dart';

class FlagBoxUtil extends StatelessWidget {
  const FlagBoxUtil(
      {super.key,
      required this.isSelected,
      required this.index,
      required this.isForTile});
  final bool isSelected;
  final int index;
  final bool isForTile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: isForTile ? 5 : 10, horizontal: isForTile ? 10 : 20),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.darkGrayColor),
      child: Column(
        children: [
          isForTile
              ? const Icon(
                  BoxIcons.bxs_flag,
                  color: Colors.white,
                  size: 15,
                )
              : AppIcons.flagIcon,
          Text(
            index.toString(),
            style: AppTextStyles.normalWhiteText
                .copyWith(fontSize: isForTile ? 10 : null),
          ),
        ],
      ),
    );
  }
}
