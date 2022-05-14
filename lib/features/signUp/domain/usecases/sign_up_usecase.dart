import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/signUp/domain/repositories/sign_up_repository.dart';

enum Type { doctor, student }
enum Gender { male, female }

class SignUpUseCase implements UseCase<UserCredential, Params> {
  final SignUpRepository signUpRepository;
  SignUpUseCase(this.signUpRepository);
  @override
  Future<Either<Failure, UserCredential>> call(Params params) {
    return signUpRepository.signUp(params);
  }
}

class Params extends Equatable {
  final String email;
  final String name;
  final String password;
  final File image;
  final Type type;
  final Gender gender;
  const Params({
    required this.gender,
    required this.type,
    required this.email,
    required this.name,
    required this.password,
    required this.image,
  });

  @override
  List<Object?> get props => [email, name, password, type, gender];
}
