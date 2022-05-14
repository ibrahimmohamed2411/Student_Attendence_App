import 'package:dartz/dartz.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:student_attendance/core/error/failures.dart';

abstract class StudentRepository {
  Future<Either<Failure, String>> recordStudent(Barcode barcode);
}
