import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_local_data_source.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_remote_data_source.dart';
import 'package:student_attendance/features/signUp/data/repositories/sign_up_repository_imp.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';

class MockSignUpRemoteDataSource extends Mock
    implements SignUpRemoteDataSource {}

class MockSignUpLocalDataSource extends Mock implements SignUpLocalDataSource {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late SignUpRepositoryImp signUpRepositoryImp;
  late MockSignUpRemoteDataSource mockSignUpRemoteDataSource;
  late MockSignUpLocalDataSource mockSignUpLocalDataSource;
  late MockUserCredential mockUserCredential;
  setUp(
    () {
      mockSignUpRemoteDataSource = MockSignUpRemoteDataSource();
      mockSignUpLocalDataSource = MockSignUpLocalDataSource();
      mockUserCredential = MockUserCredential();
      signUpRepositoryImp = SignUpRepositoryImp(
          remoteDataSource: mockSignUpRemoteDataSource,
          signUpLocalDataSource: mockSignUpLocalDataSource);
    },
  );

  group('sign up ', () {
    final params = Params(
      image: File('/test/file'),
      email: 'email',
      gender: Gender.male,
      name: 'name',
      type: Type.student,
      password: 'password',
    );
    test(
        'should return UserCredential  when the call to remote sata source is successfully',
        () async {
      when(() => mockSignUpRemoteDataSource.signUpWithEmailAndPassword(
              params.email, params.password))
          .thenAnswer((_) async => mockUserCredential);
      when(
        () => mockSignUpRemoteDataSource.uploadUserData(
          gender: params.gender.name,
          image: params.image,
          type: params.type.name,
          name: params.name,
          email: params.email,
        ),
      ).thenAnswer((_) async => Future.value());
      final result = await signUpRepositoryImp.signUp(params);
      verify(() => mockSignUpRemoteDataSource.signUpWithEmailAndPassword(
          params.email, params.password));
      verify(() => mockSignUpRemoteDataSource.uploadUserData(
            gender: params.gender.name,
            image: params.image,
            type: params.type.name,
            name: params.name,
            email: params.email,
          ));
      expect(result, equals(right(mockUserCredential)));
    });
    final failure = ServerFailure(
        'The email address is already in use by another account.');
    test(
        'should return ServerFailure  when the call to remote sata source is Failed',
        () async {
      when(() =>
          mockSignUpRemoteDataSource.signUpWithEmailAndPassword(
              params.email, params.password)).thenThrow(FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'The email address is already in use by another account.'));
      when(
        () => mockSignUpRemoteDataSource.uploadUserData(
          gender: params.gender.name,
          image: params.image,
          type: params.type.name,
          name: params.name,
          email: params.email,
        ),
      ).thenAnswer((_) async => Future.value());
      final result = await signUpRepositoryImp.signUp(params);
      verify(() => mockSignUpRemoteDataSource.signUpWithEmailAndPassword(
          params.email, params.password));
      expect(result, equals(Left(failure)));
    });
    final userImage = File('');
    test('should return ImageFile when user pick it', () async {
      when(() => mockSignUpLocalDataSource.pickUserImage(ImageSource.camera))
          .thenAnswer(
        (_) async => userImage,
      );
      final file = await signUpRepositoryImp.pickUserImage(ImageSource.camera);
      expect(file, equals(Right(userImage)));
    });
    test('should return CacheException when user does not pick picture',
        () async {
      when(() => mockSignUpLocalDataSource.pickUserImage(ImageSource.camera))
          .thenThrow(PlatformException(
              code: '', message: 'user does not pick picture'));
      final file = await signUpRepositoryImp.pickUserImage(ImageSource.camera);
      expect(file, equals(Left(CacheFailure('user does not pick picture'))));
    });
  });
}
