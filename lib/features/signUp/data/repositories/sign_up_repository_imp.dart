import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_local_data_source.dart';
import 'package:student_attendance/features/signUp/data/datasources/sign_up_remote_data_source.dart';
import 'package:student_attendance/features/signUp/domain/repositories/sign_up_repository.dart';
import 'package:student_attendance/features/signUp/domain/usecases/sign_up_usecase.dart';

class SignUpRepositoryImp implements SignUpRepository {
  final SignUpLocalDataSource signUpLocalDataSource;
  final SignUpRemoteDataSource remoteDataSource;
  SignUpRepositoryImp({
    required this.remoteDataSource,
    required this.signUpLocalDataSource,
  });
  @override
  Future<Either<Failure, UserCredential>> signUp(Params params) async {
    try {
      final userCredential = await remoteDataSource.signUpWithEmailAndPassword(
        params.email,
        params.password,
      );

      await remoteDataSource.uploadUserData(
        gender: params.gender.name,
        type: params.type.name,
        name: params.name,
        email: params.email,
        image: params.image,
      );
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, File>> pickUserImage(ImageSource imageSource) async {
    try {
      final userImage = await signUpLocalDataSource.pickUserImage(imageSource);
      return Right(userImage);
    } on PlatformException catch (e) {
      return Left(CacheFailure(e.message!));
    }
  }
}
