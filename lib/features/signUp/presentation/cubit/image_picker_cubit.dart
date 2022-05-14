import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/features/signUp/domain/usecases/pick_image_usecase.dart';

class ImagePickerCubit extends Cubit<File?> {
  final PickImageUseCase pickImageUseCase;
  ImagePickerCubit({required this.pickImageUseCase}) : super(null);
  Future<void> pickUserImage(ImageSource imageSource) async {
    final imageOrFailure = await pickImageUseCase(imageSource);
    imageOrFailure.fold(
      (failure) => () {
        print('failure in image load');
      },
      (file) => emit(file),
    );
  }
}
