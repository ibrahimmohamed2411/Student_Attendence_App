import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/core/usecases/usecase.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';

class GetAttendingStudents implements UseCase<List<Student>, NoParams> {
  final DrRepository repository;
  GetAttendingStudents({required this.repository});
  @override
  Future<Either<Failure, List<Student>>> call(NoParams params) {
    return repository.attendingStudents();
  }
}

class NoParams {}
