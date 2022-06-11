import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/settings/domain/entities/mode.dart';
import 'package:student_attendance/features/settings/domain/repositories/settings_repository.dart';

class SaveCurrentModeUseCase extends UseCase<Unit, Mode> {
  final SettingsRepository repository;
  SaveCurrentModeUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(Mode mode) {
    return repository.saveCurrentMode(mode.isDark);
  }
}
