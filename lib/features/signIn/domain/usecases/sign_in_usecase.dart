import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/signIn/domain/repositories/sign_in_repository.dart';

class SignInUseCase implements UseCase<UserCredential, SignInParams> {
  final SignInRepository signInRepository;
  SignInUseCase({required this.signInRepository});
  @override
  Future<Either<Failure, UserCredential>> call(SignInParams params) async {
    return signInRepository.signInWithEmailAndPassword(
        params.email, params.password);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;
  SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
