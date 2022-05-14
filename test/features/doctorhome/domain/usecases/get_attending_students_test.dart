import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_attendance/features/doctorhome/data/models/student_model.dart';
import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';
import 'package:student_attendance/features/doctorhome/domain/usecases/get_attendingStudents.dart';

class MockDrRepository extends Mock implements DrRepository {}

void main() {
  late GetAttendingStudents attendingStudents;
  late MockDrRepository mockDrRepository;
  setUp(() {
    mockDrRepository = MockDrRepository();
    attendingStudents = GetAttendingStudents(repository: mockDrRepository);
  });
  test('should trigger attendingStudents from repository', () {
    when(() => mockDrRepository.attendingStudents()).thenAnswer(
      (_) async => Right(
        [
          StudentModel(
            name: 'name',
            imageUrl: 'imageUrl',
            numOfAttendenceLectures: 1,
          )
        ],
      ),
    );
    attendingStudents.call(NoParams());
    verify(() => mockDrRepository.attendingStudents());
  });
}
