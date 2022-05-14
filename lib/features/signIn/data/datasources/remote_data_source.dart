import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRemoteDataSource {
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
}

class SignInRemoteDataSourceImp implements SignInRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  SignInRemoteDataSourceImp({required this.firebaseAuth});
  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
