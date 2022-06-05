import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/cubit/image_picker_cubit.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/dr_local_data_source.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/generate_qr_code_usecase.dart';
import 'package:student_attendance/features/doctorhome/presentation/bloc/dr_home_bloc.dart';
import 'package:student_attendance/features/studenthome/data/repositories/student_repository_imp.dart';
import 'package:student_attendance/features/studenthome/domain/repositories/student_repository.dart';
import 'package:student_attendance/features/studenthome/domain/usecases/record_student_usecase.dart';
import 'package:student_attendance/features/studenthome/presentation/bloc/qr_cubit.dart';

import 'features/authentication/data/datasources/authentication_local_data_source.dart';
import 'features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'features/authentication/data/repositories/authentication_repository_imp.dart';
import 'features/authentication/domain/usecases/sign_up_usecase.dart';
import 'features/doctorhome/data/datasources/dr_remote_data_source.dart';
import 'features/doctorhome/data/repositories/dr_repository_imp.dart';
import 'features/doctorhome/domain/repositories/dr_repository.dart';
import 'features/doctorhome/domain/usecases/get_attendingStudents.dart';
import 'features/studenthome/data/datasources/student_remote_data_source.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Sign Up
  //Bloc
  // sl.registerFactory(() => SignupBloc(signUpUseCase: sl()));
  // sl.registerFactory(() => ImagePickerCubit(pickImageUseCase: sl()));
  // Use Cases
  // sl.registerLazySingleton(() => SignUpUseCase(sl()));
  // sl.registerLazySingleton(() => PickImageUseCase(sl()));

  //repository
  // sl.registerLazySingleton<SignUpRepository>(
  //   () => SignUpRepositoryImp(
  //     remoteDataSource: sl(),
  //     signUpLocalDataSource: sl(),
  //   ),
  // );
  //Data Sources
  // sl.registerLazySingleton<SignUpRemoteDataSource>(
  //   () => SignUpRemoteDataSourceImp(
  //       firebaseFirestore: sl(), firebaseAuth: sl(), firebaseStorage: sl()),
  // );
  // sl.registerLazySingleton<SignUpLocalDataSource>(
  //   () => SignUpLocalDataSourceImp(imagePicker: sl()),
  // );

  //! Core

  //! External
  // final firebaseAuth = FirebaseAuth.instance;
  // final firebaseFirestore = FirebaseFirestore.instance;
  // final firebaseStorage = FirebaseStorage.instance;
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // sl.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  // sl.registerLazySingleton(() => firebaseFirestore);
  // sl.registerLazySingleton(() => firebaseStorage);
  // sl.registerLazySingleton(() => ImagePicker());

  //! Features - Authentication
  //Bloc
  sl.registerFactory(
      () => AuthenticationBloc(signInUseCase: sl(), signUpUseCase: sl()));
  sl.registerFactory(() => ImagePickerCubit(imagePicker: sl()));

  // Use Cases
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  //Data Sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImp(
        firebaseAuth: sl(), firebaseFirestore: sl(), firebaseStorage: sl()),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImp(firebaseAuth: sl()),
  );
  sl.registerLazySingleton<IImagePicker>(
      () => ImagePickerImp(imagePicker: sl()));

  //external
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => ImagePicker());

  //Features - DocHome
  //Bloc
  sl.registerFactory(
      () => DrHomeBloc(getAttendingStudents: sl(), generateQrCode: sl()));

  //Use Cases
  sl.registerLazySingleton(() => GetAttendingStudentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GenerateQrCodeUseCase(repository: sl()));

  //repository
  sl.registerLazySingleton<DrRepository>(
    () => DrRepositoryImp(remoteDataSource: sl(), localDataSource: sl()),
  );
  // Data Sources
  sl.registerLazySingleton<DrRemoteDataSource>(
    () => DrRemoteDataSourceImp(firebaseFirestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<DrLocalDataSource>(
    () => DrLocalDataSourceImp(firebaseAuth: sl()),
  );

  //! Features - Student home
  sl.registerFactory(() => QrCubit(recordStudentUseCase: sl()));
  sl.registerLazySingleton(() => RecordStudentUseCase(repository: sl()));
  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImp(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<StudentRemoteDataSource>(() =>
      StudentRemoteDataSourceImp(firebaseFirestore: sl(), firebaseAuth: sl()));
}
