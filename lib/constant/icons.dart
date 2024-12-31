import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_assign/constant/colors.dart';

class AppIcons {
  static Icon appBarIcon1 = const Icon(
    AntDesign.menu_outline,
    color: Colors.white,
  );
  static Icon appBarIcon2 =
      const Icon(AntDesign.user_outline, color: Colors.white);

  static Icon clockIcon =
      const Icon(AntDesign.clock_circle_outline, color: Colors.white);

  static Icon tagIcon =
      const Icon(BoxIcons.bxs_purchase_tag_alt, color: Colors.white);

  static Icon flagIcon = const Icon(BoxIcons.bxs_flag, color: Colors.white);

  static Icon sendIcon = Icon(Bootstrap.send, color: AppColors.primaryColor);

  static Icon searchIcon = const Icon(
    BoxIcons.bx_search,
    color: Colors.white,
  );

  static Icon searchSendIcon = const Icon(
    BoxIcons.bxs_send,
    color: Colors.white,
  );
  static List<dynamic> categoryIconList = [
    [
      const Icon(
        Clarity.shopping_bag_line,
        color: Color(0xff21A300),
      ),
      "Grocery",
      1
    ],
    [
      const Icon(
        Clarity.building_line,
        color: Color(0xffA31D00),
      ),
      "Work",
      2
    ],
    [
      const Icon(
        OctIcons.trophy,
        color: Color(0xff21A300),
      ),
      "Sport",
      3
    ],
    [
      const Icon(
        OctIcons.device_desktop,
        color: Color(0xff00A372),
      ),
      "Design",
      4
    ],
    [
      const Icon(
        OctIcons.book,
        color: Color(0xff0055A3),
      ),
      "University",
      5
    ],
    [Brand(Brands.snapchat), "Social", 6],
    [Brand(Brands.spotify), "Music", 7],
    [
      Brand(
        Brands.onix_client,
      ),
      "Health",
      8
    ],
    [Brand(Brands.disney_logo), "Movie", 9],
    [
      const Icon(
        BoxIcons.bx_home_smile,
        color: Color(0xffA36200),
      ),
      "Home",
      10
    ]
  ];
}
