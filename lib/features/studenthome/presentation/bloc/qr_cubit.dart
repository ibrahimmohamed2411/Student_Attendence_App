import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/record_student.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  final RecordStudent recordStudentUseCase;
  QrCubit({required this.recordStudentUseCase}) : super(QrInitial());
  Future<void> recordStudent(Barcode barcode) async {
    // print(barcode.code);
    final successOrFailure = checkBarCode(barcode.code!);
    successOrFailure.fold((l) => emit(Error(msg: l.msg)), (r) async {
      emit(Loading());
      final s = await recordStudentUseCase(Params(barcode: barcode));
      emit(
        s.fold(
          (l) => Error(msg: l.msg),
          (r) => Success(msg: 'success'),
        ),
      );
    });
  }
}

Either<Failure, Success> checkBarCode(String code) {
  if (code.contains('/') || code.contains('.')) {
    return Left(CacheFailure('Invalid barcode'));
  }
  return Right(Success(msg: 'success'));
}
