import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/features/profile/domain/usecases/upload_user_photo.dart';

import '../../../authentication/presentation/bloc/cubit/image_picker_cubit.dart';

// part 'update_user_photo_state.dart';

class UpdateUserPhotoCubit extends Cubit<String?> {
  final IImagePicker imagePicker;
  final UploadUserPhotoUseCase userPhotoUseCase;
  UpdateUserPhotoCubit(
      {String? initialState,
      required this.imagePicker,
      required this.userPhotoUseCase})
      : super(initialState);
  Future<void> pickUserImage(ImageSource imageSource) async {
    File? userImage = await imagePicker.pickUserImage(imageSource);
    if (userImage != null) {
      await uploadPhoto(userImage);
    }
  }

  Future<void> uploadPhoto(File image) async {
    final failureOrImageUrl = await userPhotoUseCase(image);
    failureOrImageUrl.fold((failure) => Unit, (imageUrl) => emit(imageUrl));
  }
}
