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
  Future<Either<Failure, String>> recordStudent(Barcode barcode) async {
    try {
      final userData = await remoteDataSource.getUserData();
      final userAttendenceInfo =
          await remoteDataSource.getStudentAttendenceInfo(barcode.code!);
      if (userAttendenceInfo != null) {
        await remoteDataSource.updateStudentAttendence(
            barcode.code!, userAttendenceInfo);
      } else {
        await remoteDataSource.recordStudentForFirstTime(
            barcode.code!, userData);
      }
      return Right('Success');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
}
// if (userAttendenceDoc.exists) {
//   final date = DateTime.parse(userAttendenceDoc['lastLecDate']);
//   final todayDate = DateTime.now();
//   if (todayDate.day == date.day &&
//       todayDate.month == date.month &&
//       todayDate.year == date.year) {
//     return Left(ServerFailure('You recorded before'));
//   } else {
//     await firebaseFirestore //getUserattendanceDocument
//         .collection('attending students')
//         .doc(barcode.code)
//         .collection('students')
//         .doc(firebaseAuth.currentUser!.uid)
//         .set(
//       {
//         'numberOfAttendenceLec':
//             userAttendenceDoc['numberOfAttendenceLec'] + 1,
//         'lastLecDate': DateTime.now().toIso8601String(),
//       },
//       SetOptions(
//         merge: true,
//       ),
//     );
//   }
// }

// await firebaseFirestore //first attendence lec
//     .collection('attending students')
//     .doc(barcode.code)
//     .collection('students')
//     .doc(firebaseAuth.currentUser!.uid)
//     .set(
//   {
//     'name': userData['name'],
//     'imageUrl': userData['imageUrl'],
//     'numberOfAttendenceLec': 1,
//     'lastLecDate': DateTime.now().toIso8601String(),
//   },
// );
