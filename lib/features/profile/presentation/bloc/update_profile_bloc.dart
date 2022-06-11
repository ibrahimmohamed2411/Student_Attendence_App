import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/update_user_data_usecase.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateProfileState> {
  final UpdateUserDataUseCase updateUserDataUseCase;
  UpdateProfileBloc({required this.updateUserDataUseCase})
      : super(UpdateProfileInitial()) {
    on<UpdateUserProfileEvent>(
      (event, emit) async {
        emit(UserProfileUpdateLoadingState());
        final updateProfileSuccessOrFailure =
            await updateUserDataUseCase(UpdateUserProfileParams(
          email: event.email,
          password: event.password,
          name: event.name,
          imageUrl: event.imageUrl,
        ));
        emit(
          updateProfileSuccessOrFailure.fold(
            (failure) => UserProfileUpdatedErrorState(msg: failure.msg),
            (_) => UserProfileUpdatedSuccessState(
                msg: 'Profile Updated Successfully'),
          ),
        );
      },
    );
  }
}
