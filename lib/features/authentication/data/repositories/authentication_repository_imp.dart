import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/authentication/data/datasources/authentication_local_data_source.dart';
import 'package:student_attendance/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:student_attendance/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_up_usecase.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  AuthenticationRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await remoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(SignUpUserParams params) async {
    try {
      await remoteDataSource.signUpWithEmailAndPassword(
        params.email,
        params.password,
      );

      await remoteDataSource.uploadUserData(
        gender: params.gender.name,
        role: params.type.name,
        name: params.name,
        email: params.email,
        image: params.image,
      );
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Stream<DocumentSnapshot<Object?>> userRoleChanges() {
    return remoteDataSource.userRoleChanges();
  }

  @override
  Stream<User?> autoStateChanges() {
    return localDataSource.authStateChanges();
  }

  @override
  void signOut() {
    localDataSource.signOut();
  }
}
