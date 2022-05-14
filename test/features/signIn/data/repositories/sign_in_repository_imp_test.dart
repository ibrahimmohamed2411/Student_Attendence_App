import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/signIn/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/signIn/data/repositories/sign_in_repository_imp.dart';
import 'package:student_attendance/features/signIn/domain/usecases/sign_in_usecase.dart';

class MockSignInRemoteDataSource extends Mock
    implements SignInRemoteDataSource {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late SignInRepositoryImp signInRepositoryImp;
  late MockSignInRemoteDataSource remoteDataSource;
  late MockUserCredential userCredential;
  setUp(() {
    userCredential = MockUserCredential();
    remoteDataSource = MockSignInRemoteDataSource();
    signInRepositoryImp =
        SignInRepositoryImp(remoteDataSource: remoteDataSource);
  });
  final signInParams = SignInParams(email: 'email', password: 'password');
  group('sign in', () {
    test('should return UserCredential when user success to log in', () async {
      when(() => remoteDataSource.signInWithEmailAndPassword(
              email: signInParams.email, password: signInParams.password))
          .thenAnswer((_) async => userCredential);
      final result = await signInRepositoryImp.signInWithEmailAndPassword(
          signInParams.email, signInParams.password);
      verify(() => remoteDataSource.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password));
      expect(result, equals(Right(userCredential)));
    });
    test('should return ServerFailure when user failed to log in', () async {
      when(() => remoteDataSource.signInWithEmailAndPassword(
              email: signInParams.email, password: signInParams.password))
          .thenThrow(FirebaseAuthException(code: '', message: 'error message'));
      final result = await signInRepositoryImp.signInWithEmailAndPassword(
          signInParams.email, signInParams.password);
      verify(() => remoteDataSource.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password));
      expect(result, equals(Left(ServerFailure('error message'))));
    });
  });
}
