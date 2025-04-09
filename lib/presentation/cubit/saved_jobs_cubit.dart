import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';

class SavedJobsCubit extends Cubit<List<Job>> {
  SavedJobsCubit() : super([]);

  void toggleSaved(Job job) {
    final isSaved = state.contains(job);
    if (isSaved) {
      emit(state.where((j) => j != job).toList());
    } else {
      emit([...state, job]);
    }
  }

  bool isSaved(Job job) {
    return state.contains(job);
  }
}
