import 'package:student_attendance/features/studenthome/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel(
      {required String imageUrl, required String name, required String email})
      : super(imageUrl: imageUrl, name: name, email: email);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'email': email,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'],
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }
  // factory UserDataModel.fromQueryDocumentSnapshot(
  //     QueryDocumentSnapshot<Map<String, dynamic>> json) {
  //   return UserDataModel(
  //     name: json['name'],
  //     imageUrl: json['imageUrl'],
  //     email: json['email'],
  //   );
  // }
}
