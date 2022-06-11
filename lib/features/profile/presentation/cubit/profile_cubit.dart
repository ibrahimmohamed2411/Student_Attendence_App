import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_attendance/features/profile/domain/entities/profile.dart';

import '../../../doctorhome/domain/usecases/get_attendingStudents.dart';
import '../../domain/usecases/get_user_data_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserDataUseCase getUserDataUseCase;
  ProfileCubit({required this.getUserDataUseCase}) : super(ProfileInitial());
  Future<void> getUserData() async {
    emit(GetUserProfileLoadingState());
    final userDataOrFailure = await getUserDataUseCase(NoParams());
    emit(userDataOrFailure.fold(
        (failure) => UserProfileErrorState(msg: failure.msg),
        (profileData) =>
            UserProfileDataSuccessLoadedState(profile: profileData)));
  }
}
