import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/notes_bloc/note_state.dart';

import 'package:todo_assign/models/note_model.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this.notes) : super(NoteInitialState());

  final List<NoteDataModel> notes;

  void addNote(NoteDataModel note) {
    emit(NoteLoadingState());
    notes.add(note);
    emit(NoteLoadedState(notesData: notes));
  }

  void removeNote(NoteDataModel note) {
    notes.remove(note);
    emit(NoteLoadedState(notesData: notes));
    if (notes.isEmpty) {
      emit(NoteEmptyState());
    }
  }
}
