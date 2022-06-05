part of 'dr_home_bloc.dart';

abstract class DrHomeEvent extends Equatable {
  const DrHomeEvent();
}

class GetAttendingStudentsEvent extends DrHomeEvent {
  @override
  List<Object> get props => [];
}

class GenerateQrCodeEvent extends DrHomeEvent {
  @override
  List<Object> get props => [];
}
