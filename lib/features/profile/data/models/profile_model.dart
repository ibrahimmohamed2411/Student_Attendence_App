import 'package:student_attendance/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {required String imageUrl,
      required String name,
      required String email,
      required String password})
      : super(
          imageUrl: imageUrl,
          name: name,
          email: email,
          password: password,
        );

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      password: map['password'],
      email: map['email'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
