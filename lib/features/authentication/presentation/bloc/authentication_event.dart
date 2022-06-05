part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignInEvent extends AuthenticationEvent {
  final String email;
  final String password;
  SignInEvent({required this.password, required this.email});

  @override
  List<Object?> get props => [email, password];
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String name;
  final String password;
  final File image;
  final Role role;
  final Gender gender;
  const SignUpEvent(
      {required this.name,
      required this.role,
      required this.email,
      required this.password,
      required this.image,
      required this.gender});
  @override
  List<Object?> get props => [email, name, password, image, role, gender];
}
