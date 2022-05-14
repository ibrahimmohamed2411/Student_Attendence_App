part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class Error extends SignupState {
  final String message;
  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loading extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignUpSuccess extends SignupState {
  final UserCredential userCredential;
  const SignUpSuccess({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}
