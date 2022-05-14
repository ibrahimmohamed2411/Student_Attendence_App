part of 'get_attending_students_cubit.dart';

abstract class GetAttendingStudentsState extends Equatable {
  const GetAttendingStudentsState();
}

class GetAttendingStudentsInitial extends GetAttendingStudentsState {
  @override
  List<Object> get props => [];
}

class Loading extends GetAttendingStudentsState {
  @override
  List<Object?> get props => [];
}

class Error extends GetAttendingStudentsState {
  final String message;
  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loaded extends GetAttendingStudentsState {
  final List<Student> students;
  Loaded({required this.students});

  @override
  List<Object?> get props => [students];
}
