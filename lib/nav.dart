import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:todo_assign/bloc/notes_bloc/category_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/flag_cubit.dart';
import 'package:todo_assign/bloc/search_bloc/search_bloc.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/screens/index_page.dart';
import 'package:todo_assign/screens/posts_page.dart';
import 'package:todo_assign/widgets/add_tasks_widget.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const IndexPage(),
          item: ItemConfig(
              inactiveBackgroundColor: Colors.white,
              activeForegroundColor: Colors.white,
              icon: const Icon(EvaIcons.home_outline),
              title: "Index",
              textStyle: AppTextStyles.normalWhiteText),
        ),
        PersistentTabConfig.noScreen(
          onPressed: (context) {
            BlocProvider.of<CategoryCubit>(context).removeCategory();
            BlocProvider.of<FlagCubit>(context).removeFlag();
            showModalBottomSheet(
              backgroundColor: AppColors.grayColor,
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskWidget(),
              ),
            );
          },
          item: ItemConfig(
            inactiveBackgroundColor: AppColors.primaryColor,
            activeForegroundColor: AppColors.primaryColor,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            title: " ",
          ),
        ),
        PersistentTabConfig(
          screen: BlocProvider(
              create: (context) => SearchBloc(), child: const PostsPage()),
          item: ItemConfig(
              inactiveBackgroundColor: Colors.white,
              activeForegroundColor: Colors.white,
              icon: const Icon(AntDesign.inbox_outline),
              title: "Posts",
              textStyle: AppTextStyles.normalWhiteText),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style13BottomNavBar(
        navBarDecoration: NavBarDecoration(color: AppColors.grayColor),
        navBarConfig: navBarConfig,
      ),
    );
  }
}
