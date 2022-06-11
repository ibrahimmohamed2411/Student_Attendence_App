import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance/features/settings/data/models/mode_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class SettingsLocalDataSource {
  Future<ModeModel> getCurrentMode();
  Future<Unit> saveCurrentMode(ModeModel model);
}

const IS_DARK = 'isDark';

class SettingsLocalDataSourceImp implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;
  SettingsLocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<ModeModel> getCurrentMode() async {
    final jsonString = await sharedPreferences.getString(IS_DARK);

    if (jsonString != null) {
      return Future.value(ModeModel.fromJson(json.decode(jsonString)));
    }
    throw CacheException();
  }

  @override
  Future<Unit> saveCurrentMode(ModeModel model) async {
    await sharedPreferences.setString(
      IS_DARK,
      json.encode(model.toJson()),
    );
    return Future.value(unit);
  }
}
