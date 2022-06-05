import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/studenthome/domain/repositories/student_repository.dart';

class RecordStudentUseCase implements UseCase<Unit, Params> {
  StudentRepository repository;
  RecordStudentUseCase({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return repository.recordStudent(params.barcode);
  }
}

class Params extends Equatable {
  final Barcode barcode;
  Params({required this.barcode});

  @override
  List<Object?> get props => [barcode];
}
