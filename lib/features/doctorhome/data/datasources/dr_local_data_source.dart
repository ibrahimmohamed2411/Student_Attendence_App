import 'package:firebase_auth/firebase_auth.dart';

abstract class DrLocalDataSource {
  Future<String> generateQrCode();
}

class DrLocalDataSourceImp implements DrLocalDataSource {
  final FirebaseAuth firebaseAuth;
  DrLocalDataSourceImp({required this.firebaseAuth});
  @override
  Future<String> generateQrCode() async {
    return firebaseAuth.currentUser!.uid;
  }
}
