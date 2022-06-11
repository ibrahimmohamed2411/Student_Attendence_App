import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/profile/domain/entities/profile.dart';
import 'package:student_attendance/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserDataUseCase extends UseCase<Unit, UpdateUserProfileParams> {
  final ProfileRepository repository;
  UpdateUserDataUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(UpdateUserProfileParams params) {
    return repository.updateUserProfile(
      Profile(
        imageUrl: params.imageUrl,
        name: params.name,
        email: params.email,
        password: params.password,
      ),
    );
  }
}

class UpdateUserProfileParams {
  final String email;
  final String password;
  final String name;
  final String imageUrl;
  UpdateUserProfileParams(
      {required this.email,
      required this.password,
      required this.name,
      required this.imageUrl});
}
