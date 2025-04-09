import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final JobRepository jobRepository;

  JobCubit(this.jobRepository) : super(JobInitial());

  void fetchJobs() async {
    emit(JobLoading());
    try {
      final jobs = await jobRepository.getJobs();
      emit(JobLoaded(jobs));
    } catch (e) {
      emit(JobError("Failed to fetch jobs"));
    }
  }
}
