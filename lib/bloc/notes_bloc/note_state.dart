import 'package:todo_assign/models/note_model.dart';

abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteLoadedState extends NoteState {
  final List<NoteDataModel> notesData;

  NoteLoadedState({required this.notesData});
}

class NoteEmptyState extends NoteState {}

class NoteErrorState extends NoteState {
  final String msg;

  NoteErrorState({required this.msg});
}
