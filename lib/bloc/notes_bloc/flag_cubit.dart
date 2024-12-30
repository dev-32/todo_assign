import 'package:flutter_bloc/flutter_bloc.dart';

class FlagCubit extends Cubit<int> {
  FlagCubit() : super(-1);

  void setFlag(int val) {
    emit(val);
  }

  void removeFlag() {
    emit(-1);
  }
}
