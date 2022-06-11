import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Unit> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<Unit> signUpWithEmailAndPassword(String email, String password);
  Future<Unit> uploadUserData({
    required String gender,
    required File image,
    required String role,
    required String name,
    required String email,
    required String password,
  });
  Stream<DocumentSnapshot> userRoleChanges();
}

class AuthenticationRemoteDataSourceImp
    implements AuthenticationRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firebaseFirestore;
  AuthenticationRemoteDataSourceImp(
      {required this.firebaseAuth,
      required this.firebaseStorage,
      required this.firebaseFirestore});
  @override
  Future<Unit> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return Future.value(unit);
  }

  @override
  Future<Unit> signUpWithEmailAndPassword(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> uploadUserData({
    required String gender,
    required File image,
    required String role,
    required String name,
    required String email,
    required String password,
  }) async {
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
        'role': role,
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return Future.value(unit);
  }

  @override
  Stream<DocumentSnapshot<Object?>> userRoleChanges() {
    return firebaseFirestore
        .collection('users')
        .doc(
          firebaseAuth.currentUser!.uid,
        )
        .snapshots();
  }
}
