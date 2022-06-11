import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/profile/domain/repositories/profile_repository.dart';

class UploadUserPhotoUseCase extends UseCase<String, File> {
  final ProfileRepository repository;
  UploadUserPhotoUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(File params) {
    return repository.uploadFile(params);
  }
}
