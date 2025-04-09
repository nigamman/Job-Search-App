import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/job.dart';
import '../cubit/job_cubit.dart';
import '../cubit/job_state.dart';
import 'job_detail_page.dart';
import 'package:job_search_app/presentation/cubit/saved_jobs_cubit.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  late SavedJobsCubit savedJobsCubit;

  @override
  void initState() {
    super.initState();
    context.read<JobCubit>().fetchJobs();
    savedJobsCubit = context.read<SavedJobsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color cardTextColor = isDark ? Colors.white : Colors.black;
    final Color subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final Color iconColor = isDark ? Colors.white : Colors.black87;
    final Color avatarBgColor = isDark ? Colors.black : Colors.grey.shade200;
    final Color avatarTextColor = isDark ? Colors.blueAccent : Colors.blueAccent;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<JobCubit, JobState>(
        builder: (context, state) {
          if (state is JobLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                final isSaved = context.watch<SavedJobsCubit>().isSaved(job);

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black26
                            : Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: avatarBgColor,
                      child: Text(
                        job.company.isNotEmpty ? job.company[0] : '?',
                        style: TextStyle(
                          color: avatarTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cardTextColor,
                      ),
                    ),
                    subtitle: Text(
                      job.company,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? Colors.blueAccent : Colors.grey,
                      ),
                      onPressed: () {
                        final savedJobsCubit = context.read<SavedJobsCubit>();
                        if (isSaved) {
                          savedJobsCubit.removeJob(job);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Job removed from saved'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          savedJobsCubit.saveJob(job);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Job saved successfully'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailPage(job: job),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is JobError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: cardTextColor),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
