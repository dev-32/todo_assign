import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/flag_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/utils/flag_box.dart';

class FlagsUtils extends StatefulWidget {
  const FlagsUtils({super.key});

  @override
  State<FlagsUtils> createState() => _FlagsUtilsState();
}

class _FlagsUtilsState extends State<FlagsUtils> {
  int selectedFlag = -1;
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

  void updateValue() {
    int val = BlocProvider.of<FlagCubit>(context).state;
    if (val != -1) {
      selectedFlag = val;
      indexBool[val - 1] = true;
    }
  }

  @override
  void initState() {
    super.initState();
    updateValue();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      height: size.height * 0.45,
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: AppColors.grayColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(
            AppText.taskPriority,
            style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: size.height * 0.25,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                direction: Axis.horizontal,
                children: AppText.indexNums
                    .map((val) => GestureDetector(
                        onTap: () {
                          selectedFlag = val;
                          setFalseAndTrue(val - 1, indexBool);
                        },
                        child: FlagBoxUtil(
                            isForTile: false,
                            isSelected: indexBool[val - 1],
                            index: val)))
                    .toList(),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<FlagCubit>(context).removeFlag();
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppText.cancel,
                    style: AppTextStyles.mediumWhiteText
                        .copyWith(color: AppColors.primaryColor, fontSize: 17),
                  )),
              ElevatedButton(
                  onPressed: () {
                    if (selectedFlag != -1) {
                      BlocProvider.of<FlagCubit>(context).setFlag(selectedFlag);
                      Navigator.pop(context);
                    }
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
