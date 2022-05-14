import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/signIn/domain/usecases/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  SignInCubit({required this.signInUseCase}) : super(SignInInitial());
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(Loading());
    final userCredentialOrFailure = await signInUseCase(
        SignInParams(email: email.trim(), password: password.trim()));
    emit(userCredentialOrFailure.fold((failure) => Error(msg: failure.msg),
        (userCredential) => SignInSuccess()));
  }
}
