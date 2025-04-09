import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasources/job_remote_data_source.dart';
import 'data/repositories/job_repository_impl.dart';
import 'presentation/cubit/job_cubit.dart';
import 'presentation/cubit/saved_jobs_cubit.dart';
import 'presentation/cubit/theme_cubit.dart';
import 'presentation/pages/main_page.dart';
import 'package:dio/dio.dart';

void main() {
  final jobRepository = JobRepositoryImpl(JobRemoteDataSource(Dio()));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => JobCubit(jobRepository)),
        BlocProvider(create: (_) => SavedJobsCubit()),
      ],
      child: const JobBoardApp(),
    ),
  );
}

class JobBoardApp extends StatelessWidget {
  const JobBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Job Board',
          themeMode: themeMode,
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData.dark(),
          home: const MainPage(),
        );
      },
    );
  }
}
