import 'package:dio/dio.dart';
import '../models/job_model.dart';

class JobRemoteDataSource {
  final Dio dio;

  JobRemoteDataSource(this.dio);

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await dio.get('https://remotive.io/api/remote-jobs');
      final List jobsJson = response.data['jobs'];
      return jobsJson.map((json) => JobModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load jobs: $e");
    }
  }
}
