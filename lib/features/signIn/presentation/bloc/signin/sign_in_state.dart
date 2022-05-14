part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class Loading extends SignInState {
  @override
  List<Object> get props => [];
}

class Error extends SignInState {
  final String msg;
  Error({required this.msg});
  @override
  List<Object> get props => [msg];
}

class SignInSuccess extends SignInState {
  @override
  //Todo:putting the right data
  List<Object?> get props => throw UnimplementedError();
}
