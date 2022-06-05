import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';

class GenerateQrCodeUseCase implements UseCase<String, NoParams> {
  final DrRepository repository;
  GenerateQrCodeUseCase({required this.repository});
  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return repository.generateQrCode();
  }
}
