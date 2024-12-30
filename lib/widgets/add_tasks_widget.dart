import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/category_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/flag_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/note_cubit.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/icons.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/constant/theme.dart';
import 'package:todo_assign/models/note_model.dart';
import 'package:todo_assign/utils/flags_utils.dart';
import 'package:todo_assign/utils/tags_utils.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({super.key});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descpController = TextEditingController();

  late NoteDataModel noteDataModel;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool validate = false;

  void validateText() {
    setState(() {
      validate = _taskNameController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlagCubit, int>(builder: (context, flagState) {
      return BlocBuilder<CategoryCubit, dynamic>(builder: (context, cateState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: AppColors.grayColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.addTask,
                style: AppTextStyles.boldWhiteText.copyWith(fontSize: 17),
              ),
              const SizedBox(
                height: 12,
              ),
              AutoSizeTextFormField(
                decoration: InputDecoration(
                    hintStyle: AppTextStyles.normalGreyText,
                    hintText: AppText.taskName,
                    errorMaxLines: 1,
                    errorText: validate ? "This field can't be empty" : null,
                    errorStyle: AppTextStyles.normalWhiteText
                        .copyWith(color: Colors.red, fontSize: 10),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                controller: _taskNameController,
                style: AppTextStyles.normalWhiteText,
              ),
              const SizedBox(
                height: 12,
              ),
              AutoSizeTextField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintStyle: AppTextStyles.normalGreyText,
                    hintText: AppText.descrp,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                controller: _descpController,
                style: AppTextStyles.normalWhiteText,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showTimePicker(
                                    builder: (context, child) => Theme(
                                        data: AppThemeData.calendarTheme,
                                        child: child!),
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((val) {
                              val != null ? selectedTime = val : null;
                            });
                            showDatePicker(
                                    initialDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: AppThemeData.calendarTheme,
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(4045))
                                .then((val) {
                              val != null ? selectedDate = val : null;
                            });

                            setState(() {});
                          },
                          icon: AppIcons.clockIcon),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: TagsUtils(),
                                    ));
                          },
                          icon: Badge(
                              isLabelVisible:
                                  cateState.length > 0 ? true : false,
                              backgroundColor: AppColors.primaryColor,
                              child: AppIcons.tagIcon)),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: FlagsUtils(),
                                    ));
                          },
                          icon: Badge(
                              alignment: const Alignment(1.1, -1.2),
                              isLabelVisible: flagState != -1 ? true : false,
                              backgroundColor: AppColors.primaryColor,
                              child: AppIcons.flagIcon)),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        validateText();
                        if (!validate) {
                          BlocProvider.of<NoteCubit>(context).addNote(
                              NoteDataModel(
                                  taskName: _taskNameController.text,
                                  description: _descpController.text,
                                  date: selectedDate?.toString() ?? "",
                                  time: selectedTime?.toString() ?? "",
                                  category: cateState,
                                  pritority: flagState));

                          Navigator.pop(context);
                        }
                      },
                      icon: AppIcons.sendIcon)
                ],
              )
            ],
          ),
        );
      });
    });
  }
}
