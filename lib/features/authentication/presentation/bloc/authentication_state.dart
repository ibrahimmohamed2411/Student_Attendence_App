part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class SignInLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignInSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignInErrorState extends AuthenticationState {
  final String msg;
  SignInErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class SignUpSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends AuthenticationState {
  final String msg;
  SignUpErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
