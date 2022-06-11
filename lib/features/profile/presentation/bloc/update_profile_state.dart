part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();
}

class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileUpdateLoadingState extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileUpdatedSuccessState extends UpdateProfileState {
  final String msg;
  UserProfileUpdatedSuccessState({required this.msg});
  @override
  List<Object> get props => [msg];
}

class UserProfileUpdatedErrorState extends UpdateProfileState {
  final String msg;
  UserProfileUpdatedErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
