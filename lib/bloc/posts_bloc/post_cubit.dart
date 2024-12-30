import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/posts_bloc/post_state.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/service/api_service.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitialState());

  void loadPost() async {
    emit(PostLoadingState());
    await ApiService.loadPosts().then((val) {
      if (val != null) {
        emit(PostLoadedState(dataModel: val));
      } else {
        emit(PostErrorState(message: AppText.error));
      }
    });
  }
}
