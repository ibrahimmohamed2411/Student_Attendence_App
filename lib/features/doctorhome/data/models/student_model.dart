import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel(
      {required String name,
      required String imageUrl,
      required num attendancePercentage})
      : super(
          name: name,
          imageUrl: imageUrl,
          attendancePercentage: attendancePercentage,
        );

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      attendancePercentage:
          getAttendancePercentage(json['numberOfAttendanceLec']),
    );
  }
  static num getAttendancePercentage(num numberOfLecturesAttendance) {
    return (numberOfLecturesAttendance / 10) * 100;
  }
}
