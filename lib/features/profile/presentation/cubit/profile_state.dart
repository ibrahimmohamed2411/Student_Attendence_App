part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetUserProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileDataSuccessLoadedState extends ProfileState {
  final Profile profile;
  UserProfileDataSuccessLoadedState({required this.profile});
  @override
  List<Object> get props => [profile];
}

class UserProfileErrorState extends ProfileState {
  final String msg;
  UserProfileErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}
