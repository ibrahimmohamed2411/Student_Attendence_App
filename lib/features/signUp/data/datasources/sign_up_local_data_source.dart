import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpLocalDataSource {
  Future<File> pickUserImage(ImageSource imageSource);
}

class SignUpLocalDataSourceImp implements SignUpLocalDataSource {
  final ImagePicker imagePicker;
  SignUpLocalDataSourceImp({required this.imagePicker});
  @override
  Future<File> pickUserImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 50,
    );
    if (image == null) {
      throw PlatformException(
          code: 'OPERATION_ABORTED', message: 'user does not pick picture');
    }

    return File(image.path);
  }
}
