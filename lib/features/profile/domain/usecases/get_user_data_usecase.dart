import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';
import 'package:student_attendance/features/profile/domain/entities/profile.dart';

import '../repositories/profile_repository.dart';

class GetUserDataUseCase extends UseCase<Profile, NoParams> {
  final ProfileRepository repository;
  GetUserDataUseCase({required this.repository});
  @override
  Future<Either<Failure, Profile>> call(NoParams params) {
    return repository.getUserData();
  }
}
