import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/doctorhome/data/repositories/dr_repository_imp.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';
import 'package:student_attendance/features/doctorhome/presentation/cubit/get_attending_students_cubit.dart';
import 'package:student_attendance/features/signIn/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/signIn/data/repositories/sign_in_repository_imp.dart';
import 'package:student_attendance/features/signIn/domain/repositories/sign_in_repository.dart';
import 'package:student_attendance/features/signIn/domain/usecases/sign_in_usecase.dart';
import 'package:student_attendance/features/signIn/presentation/bloc/signin/sign_in_cubit.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_local_data_source.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_remote_data_source.dart';
import 'package:student_attendance/features/signUp/domain/repositories/sign_up_repository.dart';
import 'package:student_attendance/features/signUp/domain/usecases/pick_image_usecase.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';
import 'package:student_attendance/features/signUp/presentation/bloc/signup_bloc.dart';
import 'package:student_attendance/features/signUp/presentation/cubit/image_picker_cubit.dart';

import 'features/signUp/data/repositories/sign_up_repository_imp.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Sign Up
  //Bloc
  sl.registerFactory(() => SignupBloc(signUpUseCase: sl()));
  sl.registerFactory(() => ImagePickerCubit(pickImageUseCase: sl()));
  // Use Cases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => PickImageUseCase(sl()));

  //repository
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImp(
      remoteDataSource: sl(),
      signUpLocalDataSource: sl(),
    ),
  );
  //Data Sources
  sl.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImp(
        firebaseFirestore: sl(), firebaseAuth: sl(), firebaseStorage: sl()),
  );
  sl.registerLazySingleton<SignUpLocalDataSource>(
    () => SignUpLocalDataSourceImp(imagePicker: sl()),
  );

  //! Core

  //! External
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => ImagePicker());

  //! Features - Sign in
  //Bloc
  sl.registerFactory(() => SignInCubit(signInUseCase: sl()));

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(signInRepository: sl()));

  //repository
  sl.registerLazySingleton<SignInRepository>(
    () => SignInRepositoryImp(remoteDataSource: sl()),
  );
  //Data Sources
  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImp(firebaseAuth: sl()),
  );

  //Features - DocHome
  //Bloc
  sl.registerFactory(
      () => GetAttendingStudentsCubit(getAttendingStudents: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAttendingStudents(repository: sl()));

  //repository
  sl.registerLazySingleton<DrRepository>(
    () => DrRepositoryImp(remoteDataSource: sl()),
  );
  //Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImp(firebaseFirestore: sl(), firebaseAuth: sl()),
  );
  //ToDo:maybe I need to add firestore and auth below again
}
