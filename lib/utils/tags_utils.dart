import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/category_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/icons.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/utils/category_box.dart';
import 'package:todo_assign/utils/flag_box.dart';

class TagsUtils extends StatefulWidget {
  const TagsUtils({super.key});

  @override
  State<TagsUtils> createState() => _TagsUtilsState();
}

class _TagsUtilsState extends State<TagsUtils> {
  dynamic selectedCategory = [];
  final List<bool> indexBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  void setFalseAndTrue(int index, List<bool> lst) {
    for (int i = 0; i < lst.length; i++) {
      if (i != index) {
        lst[i] = false;
      } else {
        lst[i] = true;
      }
    }
    setState(() {});
  }

  void updateOptional() {
    selectedCategory = BlocProvider.of<CategoryCubit>(context).state;
    if (selectedCategory.length > 0) {
      indexBool[selectedCategory[2] - 1] = true;
    }
  }

  @override
  void initState() {
    super.initState();
    updateOptional();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      height: 500,
      width: 400,
      decoration: BoxDecoration(
          color: AppColors.grayColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(
            AppText.chooseCateg,
            style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            direction: Axis.horizontal,
            children: AppIcons.categoryIconList.map((val) {
              return GestureDetector(
                  onTap: () {
                    selectedCategory = val;
                    setFalseAndTrue(val[2] - 1, indexBool);
                  },
                  child: CategoryBoxUtil(
                    isSelected: indexBool[val[2] - 1],
                    color: val[0],
                    val: val[1],
                  ));
            }).toList(),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<CategoryCubit>(context).removeCategory();
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppText.cancel,
                    style: AppTextStyles.mediumWhiteText
                        .copyWith(color: AppColors.primaryColor, fontSize: 17),
                  )),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CategoryCubit>(context)
                        .setCategory(selectedCategory);
                    selectedCategory.length > 0 ? Navigator.pop(context) : null;
                  },
                  child: Text(
                    AppText.save,
                    style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
