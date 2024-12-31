import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_check_box_rounded/flutter_check_box_rounded.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_assign/bloc/notes_bloc/note_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/models/note_model.dart';
import 'package:todo_assign/utils/custom_snackbar.dart';
import 'package:todo_assign/utils/date_time_format.dart';
import 'package:todo_assign/utils/flag_box.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.dataModel});
  final NoteDataModel dataModel;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isTaskDone = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Slidable(
      enabled: true,
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          borderRadius: BorderRadius.circular(12),
          icon: AntDesign.delete_outline,
          backgroundColor: AppColors.primaryColor,
          onPressed: (context) {
            BlocProvider.of<NoteCubit>(context).removeNote(widget.dataModel);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: AppColors.grayColor,
                padding: const EdgeInsets.all(0),
                content: CustomSnackbar(
                  stringContent: AppText.taskCompleted,
                )));
          },
        )
      ]),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.grayColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CheckBoxRounded(
              isChecked: isTaskDone,
              uncheckedColor: AppColors.darkGrayColor,
              checkedColor: AppColors.primaryColor,
              onTap: (val) {
                isTaskDone = val!;
                setState(() {});
                if (isTaskDone == true) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: AppColors.grayColor,
                      padding: const EdgeInsets.all(0),
                      content: CustomSnackbar(
                        stringContent: AppText.taskCompleted,
                      )));
                }
              },
            ),
            const SizedBox(
              width: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  widget.dataModel.taskName,
                  style: AppTextStyles.mediumWhiteText.copyWith(
                      fontSize: 17,
                      decoration:
                          isTaskDone ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                widget.dataModel.description.isNotEmpty
                    ? SizedBox(
                        width: 150,
                        child: AutoSizeText(
                          overflow: TextOverflow.ellipsis,
                          widget.dataModel.description,
                          style: AppTextStyles.mediumWhiteText.copyWith(
                              fontSize: 14, color: AppColors.lightTextColor),
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.dataModel.date.isNotEmpty &&
                        widget.dataModel.time.isNotEmpty
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            DateTimeFormat.formatDateTime(
                                widget.dataModel.date + widget.dataModel.time),
                            style: AppTextStyles.normalGreyText.copyWith(
                                fontSize: 13, fontStyle: FontStyle.italic),
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.dataModel.category.isNotEmpty
                    ? Container(
                        height: size.height * 0.06,
                        width: size.width * 0.1,
                        padding: const EdgeInsets.all(5),
                        decoration:
                            BoxDecoration(color: AppColors.darkGrayColor),
                        child: widget.dataModel.category[0],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 5,
                ),
                widget.dataModel.pritority > 0 &&
                        widget.dataModel.pritority < 11
                    ? SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.1,
                        child: FlagBoxUtil(
                            isForTile: true,
                            isSelected: false,
                            index: widget.dataModel.pritority),
                      )
                    : const SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }
}
