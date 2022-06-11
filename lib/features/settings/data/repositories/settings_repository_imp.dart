import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/settings/data/dataSources/settings_local_data_source.dart';
import 'package:student_attendance/features/settings/data/models/mode_model.dart';
import 'package:student_attendance/features/settings/domain/repositories/settings_repository.dart';

import '../../domain/entities/mode.dart';

class SettingsRepositoryImp implements SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;
  SettingsRepositoryImp({required this.settingsLocalDataSource});
  @override
  Future<Either<Failure, Mode>> getCurrentMode() async {
    try {
      final mode = await settingsLocalDataSource.getCurrentMode();
      return Right(mode);
    } catch (e) {
      return Left(CacheFailure('No Data'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveCurrentMode(bool mode) async {
    try {
      final modeModel = ModeModel(isDark: mode);
      await settingsLocalDataSource.saveCurrentMode(modeModel);
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure('Can\'t save theme'));
    }
  }
}
