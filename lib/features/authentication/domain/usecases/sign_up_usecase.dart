import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/core/enums/role.dart';

import '../../../../core/enums/gender.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/authentication_repository.dart';

class SignUpUseCase implements UseCase<Unit, SignUpUserParams> {
  final AuthenticationRepository repository;
  SignUpUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(SignUpUserParams params) async {
    return repository.signUp(params);
  }
}

class SignUpUserParams extends Equatable {
  final String email;
  final String name;
  final String password;
  final File image;
  final Role type;
  final Gender gender;
  SignUpUserParams({
    required this.gender,
    required this.type,
    required this.email,
    required this.name,
    required this.password,
    required this.image,
  });

  @override
  List<Object?> get props => [email, name, password, type, gender, image];
}
