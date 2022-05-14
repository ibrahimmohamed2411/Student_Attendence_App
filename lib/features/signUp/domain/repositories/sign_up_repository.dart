import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';

import '../../../../core/error/failures.dart';

abstract class SignUpRepository {
  Future<Either<Failure, UserCredential>> signUp(Params params);
  Future<Either<Failure, File>> pickUserImage(ImageSource imageSource);
}
