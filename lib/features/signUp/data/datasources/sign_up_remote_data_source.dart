import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class SignUpRemoteDataSource {
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password);
  Future<void> uploadUserData({
    required String gender,
    required File image,
    required String type,
    required String name,
    required String email,
  });
}

class SignUpRemoteDataSourceImp implements SignUpRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  SignUpRemoteDataSourceImp(
      {required this.firebaseFirestore,
      required this.firebaseAuth,
      required this.firebaseStorage});
  @override
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  @override
  Future<void> uploadUserData({
    required String gender,
    required File image,
    required String type,
    required String name,
    required String email,
  }) async {
    await firebaseAuth.currentUser!.updateDisplayName(type);
    Reference reference = await firebaseStorage
        .ref()
        .child('userImages')
        .child(firebaseAuth.currentUser!.uid);
    await reference.putFile(image);
    final imageUrl = await reference.getDownloadURL();
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(
      {
        'gender': gender,
        'imageUrl': imageUrl,
        'type': type,
        'name': name,
        'email': email,
      },
    );
  }
}
