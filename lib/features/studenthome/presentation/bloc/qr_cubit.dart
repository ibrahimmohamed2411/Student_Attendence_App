import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/record_student_usecase.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrScanState> {
  final RecordStudentUseCase recordStudentUseCase;
  QrCubit({required this.recordStudentUseCase}) : super(QrInitial());
  Future<void> recordStudent(Barcode barcode) async {
    final successOrFailure = validateBarcode(barcode.code!);
    successOrFailure.fold(
        (failure) => emit(BarcodeErrorState(msg: failure.msg)), (_) async {
      emit(BarcodeLoadingState());
      final s = await recordStudentUseCase(Params(barcode: barcode));
      emit(
        s.fold(
          (failure) => BarcodeErrorState(msg: failure.msg),
          (_) => BarcodeSuccessState(msg: 'Success'),
        ),
      );
    });
  }
}

Either<Failure, Unit> validateBarcode(String code) {
  if (code.contains('/') || code.contains('.')) {
    return Left(InvalidCodeFailure('Invalid barcode'));
  }
  return Right(unit);
}
