import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_up_usecase.dart';

import '../../../../core/enums/gender.dart';
import '../../../../core/enums/role.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  AuthenticationBloc({required this.signInUseCase, required this.signUpUseCase})
      : super(AuthenticationInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(SignInLoadingState());
      final signInSuccessOrFailure = await signInUseCase(
          SignInUserParams(email: event.email, password: event.password));
      emit(signInSuccessOrFailure.fold(
          (failure) => SignInErrorState(msg: failure.msg),
          (_) => SignInSuccessState()));
    });
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());

      final signUpSuccessOrFailure = await signUpUseCase(
        SignUpUserParams(
          name: event.name,
          password: event.password.trim(),
          email: event.email.trim(),
          gender: event.gender,
          image: event.image,
          type: event.role,
        ),
      );
      emit(
        signUpSuccessOrFailure.fold(
          (failure) => SignUpErrorState(msg: failure.msg),
          (_) => SignUpSuccessState(),
        ),
      );
    });
  }
}
