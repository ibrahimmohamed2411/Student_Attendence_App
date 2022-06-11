import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/core/utils/message_manager.dart';
import 'package:student_attendance/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/cubit/image_picker_cubit.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/dr_local_data_source.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/generate_qr_code_usecase.dart';
import 'package:student_attendance/features/doctorhome/presentation/bloc/dr_home_bloc.dart';
import 'package:student_attendance/features/profile/domain/usecases/update_user_data_usecase.dart';
import 'package:student_attendance/features/profile/domain/usecases/upload_user_photo.dart';
import 'package:student_attendance/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:student_attendance/features/profile/presentation/cubit/update_user_photo_cubit.dart';
import 'package:student_attendance/features/settings/data/dataSources/settings_local_data_source.dart';
import 'package:student_attendance/features/settings/data/repositories/settings_repository_imp.dart';
import 'package:student_attendance/features/settings/domain/repositories/settings_repository.dart';
import 'package:student_attendance/features/settings/domain/usecases/get_current_mode.dart';
import 'package:student_attendance/features/settings/domain/usecases/save_current_mode_use_case.dart';
import 'package:student_attendance/features/settings/presentation/bloc/theme/theme_cubit.dart';
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
import 'features/profile/data/datasources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_imp.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_user_data_usecase.dart';
import 'features/profile/presentation/bloc/update_profile_bloc.dart';
import 'features/studenthome/data/datasources/student_remote_data_source.dart';
import 'main.dart';

final sl = GetIt.instance;
Future<void> init() async {
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
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => ImagePicker());
  sl.registerLazySingleton<MessageManager>(() => MessageManagerImp());

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

  //! Features - Profile
  sl.registerFactory(() => ProfileCubit(getUserDataUseCase: sl()));
  sl.registerFactory(() => UpdateProfileBloc(updateUserDataUseCase: sl()));
  sl.registerFactory(
      () => UpdateUserPhotoCubit(imagePicker: sl(), userPhotoUseCase: sl()));

  sl.registerLazySingleton(() => GetUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserDataUseCase(repository: sl()));
  sl.registerLazySingleton(() => UploadUserPhotoUseCase(repository: sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImp(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImp(
          firebaseFirestore: sl(), firebaseAuth: sl(), firebaseStorage: sl()));

  //Feature - Settings
  sl.registerFactory(
      () => ThemeCubit(modeUseCase: sl(), saveCurrentModeUseCase: sl()));
  sl.registerLazySingleton(() => GetCurrentModeUseCase(repository: sl()));
  sl.registerLazySingleton(() => SaveCurrentModeUseCase(repository: sl()));
  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImp(settingsLocalDataSource: sl()));
  sl.registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImp(sharedPreferences: sl()));
}

Future<void> themeInit() async {
  final failureOrLastKnownModel =
      await sl<GetCurrentModeUseCase>().call(NoParams());
  failureOrLastKnownModel.fold(
      (failure) => isDark = false, (mode) => isDark = mode.isDark);
}
