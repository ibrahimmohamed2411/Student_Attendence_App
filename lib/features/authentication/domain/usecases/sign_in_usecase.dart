import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/authentication/domain/repositories/authentication_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SignInUseCase implements UseCase<Unit, SignInUserParams> {
  final AuthenticationRepository repository;
  SignInUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(SignInUserParams params) async {
    return repository.signInWithEmailAndPassword(params.email, params.password);
  }
}

class SignInUserParams extends Equatable {
  final String email;
  final String password;
  SignInUserParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
