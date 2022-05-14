import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/doctorhome/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/doctorhome/data/models/student_model.dart';
import 'package:student_attendance/features/doctorhome/data/repositories/dr_repository_imp.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late DrRepositoryImp repository;
  late MockRemoteDataSource remoteDataSource;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repository = DrRepositoryImp(
      remoteDataSource: remoteDataSource,
    );
  });
  group('getAttendingStudents', () {
    final students = [
      StudentModel(
        name: 'name',
        imageUrl: 'imageUrl',
        numOfAttendenceLectures: 1,
      ),
    ];
    test(
        'should return list of attending students when call to the remote data source success',
        () async {
      when(() => remoteDataSource.getAttendingStudents())
          .thenAnswer((_) async => students);
      final result = await repository.attendingStudents();
      verify(() => remoteDataSource.getAttendingStudents());
      expect(result, equals(Right(students)));
    });
    final firebaseException =
        FirebaseException(message: 'exception Occurred', plugin: 'prefix');
    test(
        'should return server failure when the call to remote sata source is unsuccessfully',
        () async {
      when(() => remoteDataSource.getAttendingStudents())
          .thenThrow(firebaseException);
      final result = await repository.attendingStudents();
      expect(result, equals(Left(ServerFailure(firebaseException.message!))));
    });
  });
}
