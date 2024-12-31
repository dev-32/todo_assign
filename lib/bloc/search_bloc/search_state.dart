import 'package:todo_assign/models/posts_model.dart';

abstract class SearchPostState {}

class SearchPostInitialState extends SearchPostState {}

class SearchPostLoadingState extends SearchPostState {}

class SearchPostLoadedState extends SearchPostState {
  final List<PostsDataModel> dataModel;

  SearchPostLoadedState({required this.dataModel});
}

class SearchPostErrorState extends SearchPostState {}
