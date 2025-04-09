import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/job.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    required int id,
    required String title,
    @JsonKey(name: 'company_name') required String company,
    required String description,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}

extension JobModelX on JobModel {
  Job toEntity() {
    return Job(
      id: id,
      title: title,
      company: company,
      description: description,
    );
  }
}
