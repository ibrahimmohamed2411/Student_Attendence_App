import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/routes/app_router.dart';
import 'package:student_attendance/injector_container.dart';

import 'features/authentication/presentation/bloc/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
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
      ],
      child: MaterialApp(
        title: 'Student Attendance',
        onGenerateRoute: widget.appRouter.onGenerateRoute,
        // home: LandingPage(),
      ),
    );
  }

  @override
  void dispose() {
    widget.appRouter.dispose();
    super.dispose();
  }
}
