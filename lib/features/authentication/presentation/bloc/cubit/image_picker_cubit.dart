import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImagePicker {
  Future<File?> pickUserImage(ImageSource imageSource);
}

class ImagePickerImp implements IImagePicker {
  final ImagePicker imagePicker;
  ImagePickerImp({required this.imagePicker});
  @override
  Future<File?> pickUserImage(ImageSource imageSource) async {
    XFile? userImage = await imagePicker.pickImage(source: imageSource);
    if (userImage != null) {
      return File(userImage.path);
    }
    return null;
  }
}

class ImagePickerCubit extends Cubit<File?> {
  IImagePicker imagePicker;
  ImagePickerCubit({required this.imagePicker}) : super(null);
  Future<void> pickUserImage(ImageSource imageSource) async {
    File? userImage = await imagePicker.pickUserImage(imageSource);
    if (userImage != null) {
      emit(userImage);
    }
  }
}
