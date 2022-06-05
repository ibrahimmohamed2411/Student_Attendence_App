import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_attendance/features/authentication/domain/usecases/sign_up_usecase.dart';

import '../../../../core/error/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Unit>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, Unit>> signUp(SignUpUserParams params);
  Stream<DocumentSnapshot> userRoleChanges();
  Stream<User?> autoStateChanges();
  void signOut();
}
