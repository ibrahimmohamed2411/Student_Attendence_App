import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationLocalDataSource {
  Stream<User?> authStateChanges();
  void signOut();
}

class AuthenticationLocalDataSourceImp
    implements AuthenticationLocalDataSource {
  final FirebaseAuth firebaseAuth;
  AuthenticationLocalDataSourceImp({required this.firebaseAuth});

  @override
  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  @override
  void signOut() {
    firebaseAuth.signOut();
  }
}
