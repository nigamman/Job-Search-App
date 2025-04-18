import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search_app/presentation/cubit/saved_jobs_cubit.dart';
import 'package:job_search_app/presentation/pages/job_detail_page.dart';
import 'package:job_search_app/domain/entities/job.dart';

class SavedJobsPage extends StatelessWidget {
  const SavedJobsPage({super.key});

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
      body: BlocBuilder<SavedJobsCubit, List<Job>>(
        builder: (context, savedJobs) {
          if (savedJobs.isEmpty) {
            return Center(
              child: Text(
                'No saved jobs yet.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: cardTextColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedJobs.length,
            itemBuilder: (context, index) {
              final job = savedJobs[index];

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
                          ? Colors.black12
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
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.redAccent,
                    tooltip: 'Remove from saved',
                    onPressed: () async {
                      final shouldRemove = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Remove Job?'),
                          content: const Text('Are you sure you want to remove this job from your saved list?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Remove', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (shouldRemove ?? false) {
                        context.read<SavedJobsCubit>().removeJob(job);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Job removed from saved'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
