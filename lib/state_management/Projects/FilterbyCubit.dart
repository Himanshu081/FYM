import 'package:cubit/cubit.dart';
import 'Filterby_state.dart';

class FilterbyCubit extends Cubit<FilterByState> {
  FilterbyCubit()
      : super(
          FilterByState(filterbyskills: false, filterbytitle: false),
        );

  void toggleFilterBySkills(bool newValue) {
    print("Sort by Skills" + newValue.toString());
    emit(state.copyWith(filterbyskills: newValue));
  }

  void toggleFilterByTitle(bool newValue) {
    print("Sort by Title" + newValue.toString());
    emit(state.copyWith(filterbytitle: newValue));
  }
}
