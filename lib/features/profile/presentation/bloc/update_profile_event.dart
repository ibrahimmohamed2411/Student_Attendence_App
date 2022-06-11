part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class UpdateUserProfileEvent extends UpdateProfileEvent {
  final String email;
  final String password;
  final String name;
  final String imageUrl;
  UpdateUserProfileEvent({
    required this.password,
    required this.email,
    required this.name,
    required this.imageUrl,
  });
  @override
  List<Object> get props => [password, email, name, imageUrl];
}
