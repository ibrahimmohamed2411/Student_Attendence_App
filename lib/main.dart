import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/routes/app_router.dart';
import 'package:student_attendance/features/settings/presentation/bloc/theme/theme_cubit.dart';
import 'package:student_attendance/injector_container.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';

late bool isDark;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  await themeInit();

  runApp(
    StudentAttendanceApp(
      appRouter: AppRouter(),
    ),
  );
}

class StudentAttendanceApp extends StatefulWidget {
  final AppRouter appRouter;

  const StudentAttendanceApp({Key? key, required this.appRouter})
      : super(key: key);

  @override
  State<StudentAttendanceApp> createState() => _StudentAttendanceAppState();
}

class _StudentAttendanceAppState extends State<StudentAttendanceApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool?>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Student Attendance',
            themeMode: state! ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
            ),
            onGenerateRoute: widget.appRouter.onGenerateRoute,
            // home: LandingPage(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.appRouter.dispose();
    super.dispose();
  }
}
