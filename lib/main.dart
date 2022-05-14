import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/doctorhome/presentation/pages/dr_home_screen.dart';
import 'package:student_attendance/features/signIn/presentation/pages/sign_in_page.dart';
import 'package:student_attendance/features/signUp/presentation/cubit/image_picker_cubit.dart';
import 'package:student_attendance/features/studenthome/data/datasources/student_remote_data_source.dart';
import 'package:student_attendance/features/studenthome/data/repositories/student_repository_imp.dart';
import 'package:student_attendance/features/studenthome/domain/usecases/record_student.dart';
import 'package:student_attendance/features/studenthome/presentation/bloc/qr_cubit.dart';
import 'package:student_attendance/features/studenthome/presentation/pages/student_home_screen.dart';
import 'package:student_attendance/injector_container.dart';

import 'features/signIn/presentation/bloc/signin/sign_in_cubit.dart';
import 'features/signUp/presentation/bloc/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<SignupBloc>(), //the hole bloc of sign up operation
        ),
        BlocProvider(
          create: (context) => sl<ImagePickerCubit>(), //pick user image
        ),
        BlocProvider(
          create: (context) => sl<SignInCubit>(),
        ),
        BlocProvider(
          create: (context) => QrCubit(
            recordStudentUseCase: RecordStudent(
              repository: StudentRepositoryImp(
                remoteDataSource: StudentRemoteDataSourceImp(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Student attendance',
        home: LandingPage(),
        // home: LandingPage(),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: sl<FirebaseAuth>().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: sl<FirebaseFirestore>()
                  .collection('users')
                  .doc(
                    sl<FirebaseAuth>().currentUser!.uid,
                  )
                  .get(),
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  final role = snapshot.data!['type'];
                  if (role == 'student') {
                    return StudentHomeScreen();
                  } else {
                    return DrHomeScreen();
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          }

          return SignInPage();
        },
      ),
    );
  }
}
