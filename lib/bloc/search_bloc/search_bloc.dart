import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/search_bloc/search_state.dart';
import 'package:todo_assign/service/api_service.dart';

class SearchBloc extends Cubit<SearchPostState> {
  SearchBloc() : super(SearchPostInitialState());

  void searchPosts(String userId) async {
    emit(SearchPostLoadingState());
    await ApiService.searchPosts(userId).then((val) {
      if (val != null && val.isNotEmpty) {
        emit(SearchPostLoadedState(dataModel: val));
      } else if (val!.isEmpty) {
        emit(SearchPostErrorState());
      } else {
        emit(SearchPostErrorState());
      }
    });
  }
}
