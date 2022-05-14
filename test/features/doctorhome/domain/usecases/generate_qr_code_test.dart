// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:student_attendance/features/doctorhome/domain/repositories/dr_repository.dart';
// import 'package:student_attendance/features/doctorhome/domain/usecases/generate_qr_code.dart';
//
// class MockDrRepository extends Mock implements DrRepository {}
//
// void main() {
//   late GenerateQrCode generateQrCode;
//   late MockDrRepository mockDrRepository;
//   setUp(() {
//     mockDrRepository = MockDrRepository();
//     generateQrCode = GenerateQrCode(repository: mockDrRepository);
//   });
//   test('should trigger generateQrCode from repository', () {
//     when(() => mockDrRepository.generateQrCode())
//         .thenAnswer((_) async => Right('data'));
//     generateQrCode.call(NoParams());
//     verify(() => mockDrRepository.generateQrCode());
//   });
// }
