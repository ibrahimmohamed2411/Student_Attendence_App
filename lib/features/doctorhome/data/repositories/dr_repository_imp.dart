import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/dr_remote_data_source.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';

import '../datasources/dr_local_data_source.dart';

class DrRepositoryImp extends DrRepository {
  final DrRemoteDataSource remoteDataSource;
  final DrLocalDataSource localDataSource;

  DrRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<Student>>> getAttendingStudents() async {
    try {
      final result = await remoteDataSource.getAttendingStudents();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> generateQrCode() async {
    try {
      final qrCode = await localDataSource.generateQrCode();
      return Right(qrCode);
    } catch (e) {
      return Left(CacheFailure('Error in generating qr code'));
    }
  }
}
