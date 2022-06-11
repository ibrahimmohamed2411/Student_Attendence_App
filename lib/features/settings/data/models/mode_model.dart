import 'package:student_attendance/features/settings/domain/entities/mode.dart';

class ModeModel extends Mode {
  ModeModel({required bool isDark}) : super(isDark: isDark);
  factory ModeModel.fromJson(Map<String, dynamic> json) {
    return ModeModel(
      isDark: json['isDark'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'isDark': isDark,
    };
  }
}
