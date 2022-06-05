import 'package:dartz/dartz.dart';
import 'package:qr_code_scanner/src/types/barcode.dart';
import 'package:student_attendance/core/error/exceptions.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/studenthome/data/datasources/student_remote_data_source.dart';
import 'package:student_attendance/features/studenthome/domain/repositories/student_repository.dart';

class StudentRepositoryImp implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  StudentRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, Unit>> recordStudent(Barcode barcode) async {
    try {
      final userData = await remoteDataSource.getUserData();
      final userAttendanceInfo =
          await remoteDataSource.getStudentAttendanceInfo(barcode.code!);
      if (userAttendanceInfo != null) {
        await remoteDataSource.updateStudentAttendance(
            barcode.code!, userAttendanceInfo);
      } else {
        await remoteDataSource.recordStudentForFirstTime(
            barcode.code!, userData);
      }
      return Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
}
