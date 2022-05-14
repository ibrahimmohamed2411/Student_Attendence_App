import 'package:student_attendance/features/studenthome/domain/entities/student_attendance.dart';

class StudentAttendenceModel extends StudentAttendance {
  StudentAttendenceModel(
      {required String imageUrl,
      required String name,
      required DateTime lastLecDate,
      required int numberOfAttendenceLec})
      : super(
            imageUrl: imageUrl,
            name: name,
            lastLecDate: lastLecDate,
            numberOfAttendenceLec: numberOfAttendenceLec);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'lastLecDate': lastLecDate.toIso8601String(),
      'numberOfAttendenceLec': numberOfAttendenceLec,
    };
  }

  factory StudentAttendenceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendenceModel(
        imageUrl: json['imageUrl'],
        name: json['name'],
        lastLecDate: DateTime.parse(json['lastLecDate']),
        numberOfAttendenceLec: json['numberOfAttendenceLec']);
  }
}
