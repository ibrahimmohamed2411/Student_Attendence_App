import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';

class DrRepositoryImp extends DrRepository {
  final RemoteDataSource remoteDataSource;

  DrRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<Student>>> attendingStudents() async {
    try {
      final result = await remoteDataSource.getAttendingStudents();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
