import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_assign/bloc/notes_bloc/note_cubit.dart';
import 'package:todo_assign/bloc/notes_bloc/note_state.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/icons.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/models/note_model.dart';
import 'package:todo_assign/widgets/task_tile.dart';
import 'package:todo_assign/widgets/tile_dialog_widget.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: AppIcons.appBarIcon1,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcons.appBarIcon2,
          ),
        ],
        title: Text(
          AppText.navText,
          style: AppTextStyles.normalWhiteText,
        ),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(builder: (context, notesState) {
        if (notesState is NoteErrorState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(child: SvgPicture.asset(AppText.indexImgPath)),
              Text(
                AppText.whatDoyou,
                style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppText.tapAddTask,
                style: AppTextStyles.normalWhiteText,
              )
            ],
          );
        } else if (notesState is NoteLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (notesState is NoteLoadedState) {
          return ListView.builder(
              itemCount: notesState.notesData.length,
              itemBuilder: (context, index) {
                NoteDataModel dataModel = notesState.notesData[index];

                return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              insetPadding: const EdgeInsets.all(0),
                              content: TileDialogWidget(
                                dataModel: dataModel,
                              )));
                    },
                    child: TaskTile(dataModel: dataModel));
              });
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(child: SvgPicture.asset(AppText.indexImgPath)),
              Text(
                AppText.whatDoyou,
                style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppText.tapAddTask,
                style: AppTextStyles.normalWhiteText,
              )
            ],
          );
        }
      }),
    );
  }
}
