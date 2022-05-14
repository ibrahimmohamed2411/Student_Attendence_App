part of 'qr_cubit.dart';

abstract class QrState extends Equatable {
  const QrState();
}

class QrInitial extends QrState {
  @override
  List<Object> get props => [];
}

class Loading extends QrState {
  @override
  List<Object> get props => [];
}

class Error extends QrState {
  final String msg;
  Error({required this.msg});
  @override
  List<Object> get props => [msg];
}

class Success extends QrState {
  final String msg;
  Success({required this.msg});
  @override
  List<Object> get props => [msg];
}
