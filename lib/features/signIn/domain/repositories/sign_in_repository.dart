import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failures.dart';

abstract class SignInRepository {
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      String email, String password);
}
