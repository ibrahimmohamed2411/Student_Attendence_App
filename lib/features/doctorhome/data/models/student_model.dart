import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel(
      {required String name,
      required String imageUrl,
      required num numOfAttendenceLectures})
      : super(
            name: name,
            imageUrl: imageUrl,
            numOfAttendenceLectures: numOfAttendenceLectures);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'numOfAttendenceLec': numOfAttendenceLectures,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      numOfAttendenceLectures: json['numOfAttendenceLec'],
    );
  }
  factory StudentModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return StudentModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      numOfAttendenceLectures: json['numberOfAttendenceLec'],
    );
  }
}
