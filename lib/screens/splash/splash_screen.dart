import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_assign/bloc/posts_bloc/post_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToPage();
    BlocProvider.of<PostCubit>(context).loadPost();
  }

  void navigateToPage() {
    Timer(
        const Duration(seconds: 1, milliseconds: 500),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NavWidget())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(AppText.logoPath),
          ),
          Center(
            child: Text(
              AppText.todo,
              style: AppTextStyles.normalGreyText.copyWith(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
