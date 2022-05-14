import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/core/error/failures.dart';
import 'package:student_attendance/features/signIn/data/datasources/remote_data_source.dart';
import 'package:student_attendance/features/signIn/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImp implements SignInRepository {
  final SignInRemoteDataSource remoteDataSource;
  SignInRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await remoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }
}
