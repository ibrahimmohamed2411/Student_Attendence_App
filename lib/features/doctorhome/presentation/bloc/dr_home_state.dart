part of 'dr_home_bloc.dart';

abstract class DrHomeState extends Equatable {
  const DrHomeState();
}

class DrHomeInitial extends DrHomeState {
  @override
  List<Object> get props => [];
}

class AttendingStudentsLoadingState extends DrHomeState {
  @override
  List<Object?> get props => [];
}

class AttendingStudentsErrorState extends DrHomeState {
  final String message;
  AttendingStudentsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class AttendingStudentsSuccessState extends DrHomeState {
  final List<Student> students;
  AttendingStudentsSuccessState({required this.students});

  @override
  List<Object?> get props => [students];
}

class GenerateQrCodeLoadingState extends DrHomeState {
  @override
  List<Object?> get props => [];
}

class GenerateQrCodeErrorState extends DrHomeState {
  final String message;
  GenerateQrCodeErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class GenerateQrCodeSuccessState extends DrHomeState {
  final String qrCode;
  GenerateQrCodeSuccessState({required this.qrCode});

  @override
  List<Object?> get props => [qrCode];
}
