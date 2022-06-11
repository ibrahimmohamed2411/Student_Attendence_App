import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/profile/domain/entities/profile.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, Profile>> getUserData() async {
    try {
      final userProfileData = await remoteDataSource.getUserData();
      return Right(userProfileData);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserProfile(Profile profile) async {
    try {
      await remoteDataSource.updateUserData(profile);
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(File file) async {
    try {
      final fileUrl = await remoteDataSource.uploadFile(file);
      return Right(fileUrl);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
