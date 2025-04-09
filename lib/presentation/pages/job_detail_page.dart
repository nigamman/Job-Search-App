import 'package:flutter/material.dart';
import '../../domain/entities/job.dart';

class JobDetailPage extends StatelessWidget {
  final Job job;

  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.company, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(job.description),
          ],
        ),
      ),
    );
  }
}
