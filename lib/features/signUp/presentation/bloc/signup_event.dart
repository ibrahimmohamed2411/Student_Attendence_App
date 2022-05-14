part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignUp extends SignupEvent {
  final Params params;
  const SignUp({required this.params});
  @override
  List<Object?> get props => [params];
}
