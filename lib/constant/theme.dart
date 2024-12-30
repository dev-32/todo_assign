import 'package:flutter/material.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text_styles.dart';

class AppThemeData {
  static ThemeData appTheme = ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColorDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor))),
      scaffoldBackgroundColor: AppColors.backgroundColorDark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor));

  static ThemeData calendarTheme = ThemeData.dark().copyWith(
    primaryTextTheme: TextTheme(
        bodyLarge: AppTextStyles.boldWhiteText,
        titleSmall: AppTextStyles.normalWhiteText,
        titleMedium: AppTextStyles.normalWhiteText),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      surface: AppColors.grayColor,
      onSurface: Colors.white,
    ),
  );
}
