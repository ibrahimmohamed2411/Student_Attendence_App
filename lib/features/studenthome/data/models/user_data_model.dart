import 'package:student_attendance/core/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel(
      {required String imageUrl, required String name, required String email})
      : super(imageUrl: imageUrl, name: name, email: email);

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'],
      imageUrl: json['imageUrl'],
      name: json['name'],
    );
  }
}
