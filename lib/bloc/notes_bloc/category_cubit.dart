import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<dynamic> {
  CategoryCubit() : super([]);

  void setCategory(dynamic val) {
    emit(val);
  }

  void removeCategory() {
    emit([]);
  }
}
