import 'package:student_attendance/features/studenthome/domain/entities/student_attendance.dart';

class StudentAttendanceModel extends StudentAttendance {
  StudentAttendanceModel copyWith(
      {String? name,
      String? imageUrl,
      int? numberOfAttendanceLec,
      DateTime? lastLecDate}) {
    return StudentAttendanceModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      numberOfAttendanceLec:
          numberOfAttendanceLec ?? this.numberOfAttendanceLec,
      lastLecDate: lastLecDate ?? this.lastLecDate,
    );
  }

  StudentAttendanceModel(
      {required String imageUrl,
      required String name,
      required DateTime lastLecDate,
      required int numberOfAttendanceLec})
      : super(
            imageUrl: imageUrl,
            name: name,
            lastLecDate: lastLecDate,
            numberOfAttendanceLec: numberOfAttendanceLec);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'lastLecDate': lastLecDate.toIso8601String(),
      'numberOfAttendanceLec': numberOfAttendanceLec,
    };
  }

  factory StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    return StudentAttendanceModel(
        imageUrl: json['imageUrl'],
        name: json['name'],
        lastLecDate: DateTime.parse(json['lastLecDate']),
        numberOfAttendanceLec: json['numberOfAttendanceLec']);
  }
}
