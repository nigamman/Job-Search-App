import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int id;
  final String title;
  final String company;
  final String description;

  const Job({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, company, description];
}
