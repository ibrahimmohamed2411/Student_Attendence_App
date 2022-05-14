import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/features/signIn/domain/repositories/sign_in_repository.dart';
import 'package:student_attendance/features/signIn/domain/usecases/sign_in_usecase.dart';

class MockSignInRepository extends Mock implements SignInRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late SignInUseCase signInUseCase;
  late MockSignInRepository mockSignInRepository;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockSignInRepository = MockSignInRepository();
    mockUserCredential = MockUserCredential();
    signInUseCase = SignInUseCase(signInRepository: mockSignInRepository);
  });
  final signInParams = SignInParams(email: 'email', password: 'password');
  test('get UserCredential from repository', () async {
    when(() => mockSignInRepository.signInWithEmailAndPassword(
            signInParams.email, signInParams.password))
        .thenAnswer((_) async => Right(mockUserCredential));
    final result = await signInUseCase(signInParams);
    verify(() => mockSignInRepository.signInWithEmailAndPassword(
        signInParams.email, signInParams.password));
    expect(result, equals(Right(mockUserCredential)));
  });
}
