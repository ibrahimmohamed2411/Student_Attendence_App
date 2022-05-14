import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';

import '../../domain/entities/student.dart';

part 'get_attending_students_state.dart';

class GetAttendingStudentsCubit extends Cubit<GetAttendingStudentsState> {
  final GetAttendingStudents getAttendingStudents;
  GetAttendingStudentsCubit({required this.getAttendingStudents})
      : super(GetAttendingStudentsInitial());
  Future<void> getAttendance() async {
    emit(Loading());
    final failureOrAttendingStudents = await getAttendingStudents(NoParams());
    emit(
      failureOrAttendingStudents.fold(
        (failure) => Error(message: failure.msg),
        (students) => Loaded(students: students),
      ),
    );
  }
}
