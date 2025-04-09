import '../../domain/entities/job.dart';
import '../../domain/repositories/job_repository.dart';
import '../datasources/job_remote_data_source.dart';
import 'package:job_search_app/data/models/job_model.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;

  JobRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Job>> getJobs() async {
    final jobModels = await remoteDataSource.fetchJobs();
    return jobModels.map((model) => model.toEntity()).toList();
  }
}
