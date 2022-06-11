import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/settings/domain/entities/mode.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Mode>> getCurrentMode();
  Future<Either<Failure, Unit>> saveCurrentMode(bool mode);
}
