import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';

abstract class DrRepository {
  Future<Either<Failure, List<Student>>> attendingStudents();
}
