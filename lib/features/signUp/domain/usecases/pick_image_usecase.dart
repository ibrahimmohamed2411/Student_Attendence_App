import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/sign_up_repository.dart';

class PickImageUseCase implements UseCase<File, ImageSource> {
  final SignUpRepository signUpRepository;
  PickImageUseCase(this.signUpRepository);
  @override
  Future<Either<Failure, File>> call(ImageSource imageSource) async {
    return signUpRepository.pickUserImage(imageSource);
  }
}
