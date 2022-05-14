import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/exceptions.dart';

import '../models/student_attendence_model.dart';
import '../models/user_data_model.dart';

abstract class StudentRemoteDataSource {
  Future<UserDataModel> getUserData();
  Future<StudentAttendenceModel?> getStudentAttendenceInfo(String drPath);
  Future<void> updateStudentAttendence(
      String drPath, StudentAttendenceModel studentAttendenceModel);
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

  Future<StudentAttendenceModel?> getStudentAttendenceInfo(
      String drPath) async {
    final userAttendenceDoc =
        await firebaseFirestore //getUserattendanceDocument
            .collection('attending students')
            .doc(drPath)
            .collection('students')
            .doc(firebaseAuth.currentUser!.uid)
            .get();
    if (userAttendenceDoc.data() != null) {
      return StudentAttendenceModel.fromJson(userAttendenceDoc.data()!);
    }
    return null;
  }

  Future<void> updateStudentAttendence(
      String drPath, StudentAttendenceModel studentAttendenceModel) async {
    final lastLecDate = studentAttendenceModel.lastLecDate;
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
        {
          'numberOfAttendenceLec':
              studentAttendenceModel.numberOfAttendenceLec + 1,
          'lastLecDate': DateTime.now().toIso8601String(),
        },
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  Future<void> recordStudentForFirstTime(
      String path, UserDataModel userData) async {
    await firebaseFirestore //recordStudentForFirstLec
        .collection('attending students')
        .doc(path)
        .collection('students')
        .doc(firebaseAuth.currentUser!.uid)
        .set(
      {
        'numberOfAttendenceLec': 1,
        'lastLecDate': DateTime.now().toIso8601String(),
        'name': userData.name,
        'imageUrl': userData.imageUrl,
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
