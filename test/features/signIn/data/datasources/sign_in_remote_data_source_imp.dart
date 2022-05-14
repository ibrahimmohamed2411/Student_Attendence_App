import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/features/signIn/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/signIn/domain/usecases/sign_in_usecase.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late SignInRemoteDataSourceImp signInRemoteDataSourceImp;
  late MockFirebaseAuth firebaseAuth;
  late MockUserCredential userCredential;
  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    signInRemoteDataSourceImp =
        SignInRemoteDataSourceImp(firebaseAuth: firebaseAuth);
  });
  final signInParams = SignInParams(email: 'email', password: 'password');
  group('sign in', () {
    test('should trigger signInWithEmailAndPassword from firebaseAuth',
        () async {
      when(() => firebaseAuth.signInWithEmailAndPassword(
              email: signInParams.email, password: signInParams.password))
          .thenAnswer((_) async => userCredential);
      await signInRemoteDataSourceImp.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password);
      verify(() => firebaseAuth.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password));
    });
    test(
        'should return UserCredential when user success to log in from firebaseAuth',
        () async {
      when(() => firebaseAuth.signInWithEmailAndPassword(
              email: signInParams.email, password: signInParams.password))
          .thenAnswer((_) async => userCredential);
      final result = await signInRemoteDataSourceImp.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password);
      verify(() => firebaseAuth.signInWithEmailAndPassword(
          email: signInParams.email, password: signInParams.password));
      expect(result, userCredential);
    });
    test(
        'should throw FirebaseAuthException when user failed to log in from firebaseAuth',
        () async {
      when(() => firebaseAuth.signInWithEmailAndPassword(
              email: signInParams.email, password: signInParams.password))
          .thenThrow(FirebaseAuthException(code: '', message: 'error'));
      final call = await signInRemoteDataSourceImp.signInWithEmailAndPassword;
      // verify(() => firebaseAuth.signInWithEmailAndPassword(
      //     email: signInParams.email, password: signInParams.password));
      expect(
          () =>
              call(email: signInParams.email, password: signInParams.password),
          throwsA(TypeMatcher<FirebaseAuthException>()));
    });
  });
}
