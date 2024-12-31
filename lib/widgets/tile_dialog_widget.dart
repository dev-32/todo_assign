import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/note_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/models/note_model.dart';
import 'package:todo_assign/utils/custom_snackbar.dart';
import 'package:todo_assign/utils/date_time_format.dart';
import 'package:todo_assign/utils/flag_box.dart';

class TileDialogWidget extends StatefulWidget {
  const TileDialogWidget({super.key, required this.dataModel});
  final NoteDataModel dataModel;

  @override
  State<TileDialogWidget> createState() => _TileDialogWidgetState();
}

class _TileDialogWidgetState extends State<TileDialogWidget> {
  double height = 410;
  double width = 350;
  void setHeight() {
    if (widget.dataModel.description.isNotEmpty) {
      if (widget.dataModel.category.isEmpty) height = 200;
    }
    if (widget.dataModel.description.isEmpty) {
      height = 200;
    }
    if (widget.dataModel.description.isEmpty &&
        widget.dataModel.category.isEmpty) {
      height = 160;
    }
  }

  @override
  void initState() {
    super.initState();
    setHeight();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.darkGrayColor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                widget.dataModel.taskName,
                style: AppTextStyles.boldWhiteText.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.dataModel.description.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: widget.dataModel.description.isNotEmpty
                                ? Border.all(
                                    color: AppColors.grayColor, width: 2)
                                : null),
                        child: SingleChildScrollView(
                          child: AutoSizeText(
                            widget.dataModel.description,
                            style: AppTextStyles.mediumWhiteText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            widget.dataModel.date.isNotEmpty && widget.dataModel.time.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.scheduledAt,
                        style:
                            AppTextStyles.boldWhiteText.copyWith(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.grayColor, width: 2)),
                        child: AutoSizeText(
                          DateTimeFormat.formatDateTime(
                              widget.dataModel.date + widget.dataModel.time),
                          style: AppTextStyles.normalGreyText.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            widget.dataModel.category.isNotEmpty ||
                    widget.dataModel.pritority > 0 &&
                        widget.dataModel.pritority < 11
                ? Column(
                    children: [
                      Text(
                        AppText.tags,
                        style:
                            AppTextStyles.boldWhiteText.copyWith(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: widget.dataModel.category.isNotEmpty ||
                          widget.dataModel.pritority > 0 &&
                              widget.dataModel.pritority < 11
                      ? Border.all(color: AppColors.grayColor, width: 2)
                      : null),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.dataModel.category.isNotEmpty
                      ? SizedBox(
                          child: Center(
                            child: Column(
                              children: [
                                widget.dataModel.category[0],
                                Text(
                                  AppText.categoryList[
                                      widget.dataModel.category[2] - 1],
                                  style: AppTextStyles.normalWhiteText,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    width: 5,
                  ),
                  widget.dataModel.pritority > 0 &&
                          widget.dataModel.pritority < 11
                      ? FlagBoxUtil(
                          isForTile: false,
                          isSelected: false,
                          index: widget.dataModel.pritority)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppText.close,
                      style: AppTextStyles.mediumWhiteText.copyWith(
                          color: AppColors.primaryColor, fontSize: 17),
                    )),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NoteCubit>(context)
                          .removeNote(widget.dataModel);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: AppColors.grayColor,
                          padding: const EdgeInsets.all(0),
                          content: CustomSnackbar(
                            stringContent: AppText.taskCompleted,
                          )));
                    },
                    child: Text(
                      AppText.done,
                      style:
                          AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
