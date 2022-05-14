class StudentAttendance {
  final String imageUrl;
  final DateTime lastLecDate;
  final String name;
  final int numberOfAttendenceLec;
  StudentAttendance(
      {required this.imageUrl,
      required this.name,
      required this.lastLecDate,
      required this.numberOfAttendenceLec});
}
