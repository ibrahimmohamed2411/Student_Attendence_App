// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:student_attendance/features/doctorhome/data/datasources/remote_data_source.dart';
// import 'package:student_attendance/features/doctorhome/data/models/student_model.dart';
//
// class MockFirestore extends Mock implements FirebaseFirestore {}
//
// class MockFireAuth extends Mock implements FirebaseAuth {}
//
// class MockQuerySnapshot extends Mock
//     implements QuerySnapshot<Map<String, dynamic>> {}
//
// void main() {
//   late RemoteDataSourceImp remoteDataSourceImp;
//   late MockFirestore firestore;
//   late MockFireAuth fireAuth;
//   late MockQuerySnapshot mockQuerySnapshot;
//   setUp(() {
//     firestore = MockFirestore();
//     fireAuth = MockFireAuth();
//     mockQuerySnapshot = MockQuerySnapshot();
//     remoteDataSourceImp = RemoteDataSourceImp(
//         firebaseFirestore: firestore, firebaseAuth: fireAuth);
//   });
//   group('getAttendingStudent', () {
//     final attendingStudents = [
//       StudentModel(
//           name: 'name', imageUrl: 'imageUrl', numOfAttendenceLectures: 1),
//     ];
//     // final query=await ;
//
//     test('should return Attending students when response success', () async {
//       when(
//         () => firestore.collection(any()).doc(any()).collection(any()).get(),
//       ).thenAnswer((_) async => mockQuerySnapshot);
//       final result = await remoteDataSourceImp.getAttendingStudents();
//       expect(
//         result,
//         equals(
//           mockQuerySnapshot.docs
//               .map((e) => StudentModel.fromQueryDocumentSnapshot(e))
//               .toList(),
//         ),
//       );
//     });
//   });
// }
