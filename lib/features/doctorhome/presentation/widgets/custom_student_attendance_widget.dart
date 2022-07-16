import 'package:flutter/material.dart';
import 'package:student_attendance/core/utils/media_query_values.dart';
import 'package:student_attendance/features/doctorhome/domain/entities/student.dart';

class CustomStudentAttendanceWidget extends StatelessWidget {
  final Student student;
  CustomStudentAttendanceWidget({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 110,
            width: context.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.63,
                  child: Text(
                    student.name,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Color.fromARGB(255, 53, 49, 49),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '% ${student.attendancePercentage} - attendance',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Positioned(
            top: 18,
            left: context.width * 0.70,
            child: FadeInImage(
              fit: BoxFit.cover,
              height: 100,
              width: 100,
              placeholder: AssetImage('assets/images/loading.gif'),
              image: NetworkImage(student.imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
