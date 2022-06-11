import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';
import 'package:student_attendance/features/settings/domain/entities/mode.dart';
import 'package:student_attendance/features/settings/domain/usecases/get_current_mode.dart';
import 'package:student_attendance/features/settings/domain/usecases/save_current_mode_use_case.dart';
import 'package:student_attendance/main.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<bool> {
  final GetCurrentModeUseCase modeUseCase;
  final SaveCurrentModeUseCase saveCurrentModeUseCase;
  ThemeCubit({required this.modeUseCase, required this.saveCurrentModeUseCase})
      : super(isDark);
  void toggleTheme(bool mode) async {
    final failureOrSuccessSaveMode =
        await saveCurrentModeUseCase(Mode(isDark: mode));
    emit(failureOrSuccessSaveMode.fold((failure) => !mode, (_) => mode));
  }

  Future<void> getLastMode() async {
    final failureOrLastMode = await modeUseCase(NoParams());
    emit(failureOrLastMode.fold((failure) => false, (mode) => mode.isDark));
  }
}
