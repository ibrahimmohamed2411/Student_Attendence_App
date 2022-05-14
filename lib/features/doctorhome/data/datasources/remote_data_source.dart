import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/features/doctorhome/data/models/student_model.dart';

abstract class RemoteDataSource {
  Future<List<StudentModel>> getAttendingStudents();
}

class RemoteDataSourceImp implements RemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  RemoteDataSourceImp(
      {required this.firebaseFirestore, required this.firebaseAuth});
  @override
  Future<List<StudentModel>> getAttendingStudents() async {
    QuerySnapshot<Map<String, dynamic>> students = await firebaseFirestore
        .collection('attending students')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('students')
        .get(
            // GetOptions(
            //   source: Source.server,
            // ),
            );

    return students.docs
        .map((e) => StudentModel.fromQueryDocumentSnapshot(e))
        .toList();
  }
}
