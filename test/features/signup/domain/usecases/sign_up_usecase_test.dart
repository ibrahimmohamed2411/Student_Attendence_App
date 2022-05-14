import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/features/signUp/domain/repositories/sign_up_repository.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';

class MockSignUpRepository extends Mock implements SignUpRepository {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late SignUpUseCase signUp;
  late MockSignUpRepository mockSignUpRepository;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockSignUpRepository = MockSignUpRepository();
    signUp = SignUpUseCase(mockSignUpRepository);
    mockUserCredential = MockUserCredential();
  });
  final params = Params(
    image: File(''),
    email: 'email',
    gender: Gender.male,
    name: 'name',
    type: Type.student,
    password: 'password',
  );

  test('should get the user from repository after signed up', () async {
    when(() => mockSignUpRepository.signUp(params))
        .thenAnswer((_) async => Right(mockUserCredential));

    final result = await signUp.call(params);
    expect(result, equals(Right(mockUserCredential)));
    verify(() => mockSignUpRepository.signUp(params));
  });
}
