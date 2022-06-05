import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/exceptions.dart';

import '../models/student_attendence_model.dart';
import '../models/user_data_model.dart';

abstract class StudentRemoteDataSource {
  Future<UserDataModel> getUserData();
  Future<StudentAttendanceModel?> getStudentAttendanceInfo(String drPath);
  Future<void> updateStudentAttendance(
      String drPath, StudentAttendanceModel studentAttendanceModel);
  Future<void> recordStudentForFirstTime(String path, UserDataModel userData);
}

class StudentRemoteDataSourceImp implements StudentRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  StudentRemoteDataSourceImp(
      {required this.firebaseAuth, required this.firebaseFirestore});
  @override
  Future<UserDataModel> getUserData() async {
    var userData = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    return UserDataModel.fromJson(userData.data()!);
  }

  Future<StudentAttendanceModel?> getStudentAttendanceInfo(
      String drPath) async {
    final userAttendanceDoc = await firebaseFirestore
        .collection('attending students')
        .doc(drPath)
        .collection('students')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    if (userAttendanceDoc.data() != null) {
      return StudentAttendanceModel.fromJson(userAttendanceDoc.data()!);
    }
    return null;
  }

  Future<void> updateStudentAttendance(
      String drPath, StudentAttendanceModel studentAttendanceModel) async {
    final lastLecDate = studentAttendanceModel.lastLecDate;
    final currentDate = DateTime.now();
    if (currentDate.day == lastLecDate.day &&
        currentDate.month == lastLecDate.month &&
        currentDate.year == lastLecDate.year) {
      throw ServerException(msg: 'you record yourself before');
    } else {
      await firebaseFirestore
          .collection('attending students')
          .doc(drPath)
          .collection('students')
          .doc(firebaseAuth.currentUser!.uid)
          .set(
            studentAttendanceModel
                .copyWith(
                  numberOfAttendanceLec:
                      studentAttendanceModel.numberOfAttendanceLec + 1,
                  lastLecDate: DateTime.now(),
                )
                .toJson(),
          );
    }
  }

  Future<void> recordStudentForFirstTime(
      String drPath, UserDataModel userData) async {
    final studentAttendanceModel = StudentAttendanceModel(
      name: userData.name,
      imageUrl: userData.imageUrl,
      numberOfAttendanceLec: 1,
      lastLecDate: DateTime.now(),
    );
    await firebaseFirestore
        .collection('attending students')
        .doc(drPath)
        .collection('students')
        .doc(firebaseAuth.currentUser!.uid)
        .set(studentAttendanceModel.toJson());
  }
}
