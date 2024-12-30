import 'package:todo_assign/models/posts_model.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostsDataModel> dataModel;

  PostLoadedState({required this.dataModel});
}

class PostErrorState extends PostState {
  final String message;

  PostErrorState({required this.message});
}
