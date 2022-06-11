import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:student_attendance/features/profile/data/models/profile_model.dart';

import '../../domain/entities/profile.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserData();
  Future<Unit> updateUserData(Profile profile);
  Future<String> uploadFile(File file);
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  ProfileRemoteDataSourceImp(
      {required this.firebaseFirestore,
      required this.firebaseAuth,
      required this.firebaseStorage});
  @override
  Future<ProfileModel> getUserData() async {
    final response = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    return ProfileModel.fromJson(response.data()!);
  }

  @override
  Future<Unit> updateUserData(Profile profile) async {
    final profileModel = ProfileModel(
      imageUrl: profile.imageUrl,
      name: profile.name,
      email: profile.email,
      password: profile.password,
    );
    await firebaseAuth.currentUser!.updateEmail(profileModel.email);
    await firebaseAuth.currentUser!.updatePassword(profileModel.password);
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .set(profileModel.toJson(), SetOptions(merge: true));
    return Future.value(unit);
  }

  @override
  Future<String> uploadFile(File file) async {
    Reference reference = firebaseStorage
        .ref()
        .child('userImages')
        .child(firebaseAuth.currentUser!.uid);
    await reference.putFile(file);
    final imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }
}
