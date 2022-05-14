import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase signUpUseCase;

  SignupBloc({required this.signUpUseCase}) : super(SignupInitial()) {
    on<SignUp>((event, emit) async {
      emit(Loading());

      final failureOrUserCredential = await signUpUseCase(event.params);
      emit(
        failureOrUserCredential.fold(
          (failure) => Error(message: failure.msg),
          (userCredential) => SignUpSuccess(userCredential: userCredential),
        ),
      );
    });
  }
}
