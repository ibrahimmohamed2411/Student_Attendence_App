import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/student.dart';
import '../../domain/usecases/generate_qr_code_usecase.dart';
import '../../domain/usecases/get_attendingStudents.dart';

part 'dr_home_event.dart';
part 'dr_home_state.dart';

class DrHomeBloc extends Bloc<DrHomeEvent, DrHomeState> {
  final GetAttendingStudentsUseCase getAttendingStudents;
  final GenerateQrCodeUseCase generateQrCode;
  DrHomeBloc({required this.generateQrCode, required this.getAttendingStudents})
      : super(DrHomeInitial()) {
    on<GenerateQrCodeEvent>((event, emit) async {
      emit(GenerateQrCodeLoadingState());
      final result = await generateQrCode(NoParams());
      emit(
        result.fold(
          (failure) => GenerateQrCodeErrorState(message: failure.msg),
          (qrCode) => GenerateQrCodeSuccessState(qrCode: qrCode),
        ),
      );
    });
    on<GetAttendingStudentsEvent>((event, emit) async {
      emit(AttendingStudentsLoadingState());
      final failureOrAttendingStudents = await getAttendingStudents(NoParams());
      emit(
        failureOrAttendingStudents.fold(
          (failure) => AttendingStudentsErrorState(message: failure.msg),
          (students) => AttendingStudentsSuccessState(students: students),
        ),
      );
    });
  }
}
