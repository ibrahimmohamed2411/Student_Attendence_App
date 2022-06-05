part of 'qr_cubit.dart';

abstract class QrScanState extends Equatable {
  const QrScanState();
}

class QrInitial extends QrScanState {
  @override
  List<Object> get props => [];
}

class BarcodeLoadingState extends QrScanState {
  @override
  List<Object> get props => [];
}

class BarcodeErrorState extends QrScanState {
  final String msg;
  BarcodeErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class BarcodeSuccessState extends QrScanState {
  final String msg;
  BarcodeSuccessState({required this.msg});
  @override
  List<Object> get props => [msg];
}
