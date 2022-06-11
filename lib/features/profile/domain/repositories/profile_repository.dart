import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_attendance/features/profile/domain/entities/profile.dart';

import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getUserData();
  Future<Either<Failure, Unit>> updateUserProfile(Profile profile);
  Future<Either<Failure, String>> uploadFile(File file);
}
