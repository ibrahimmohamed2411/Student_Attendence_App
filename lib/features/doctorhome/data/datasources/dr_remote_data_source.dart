import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/features/doctorhome/data/models/student_model.dart';

abstract class DrRemoteDataSource {
  Future<List<StudentModel>> getAttendingStudents();
}

class DrRemoteDataSourceImp implements DrRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  DrRemoteDataSourceImp(
      {required this.firebaseFirestore, required this.firebaseAuth});
  @override
  Future<List<StudentModel>> getAttendingStudents() async {
    QuerySnapshot<Map<String, dynamic>> students = await firebaseFirestore
        .collection('attending students')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('students')
        .get();

    return students.docs
        .map<StudentModel>((student) => StudentModel.fromJson(student.data()))
        .toList();
  }
}
