import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';
import 'package:student_attendance/features/settings/domain/entities/mode.dart';
import 'package:student_attendance/features/settings/domain/repositories/settings_repository.dart';

class GetCurrentModeUseCase extends UseCase<Mode, NoParams> {
  final SettingsRepository repository;
  GetCurrentModeUseCase({required this.repository});
  @override
  Future<Either<Failure, Mode>> call(NoParams params) {
    return repository.getCurrentMode();
  }
}
