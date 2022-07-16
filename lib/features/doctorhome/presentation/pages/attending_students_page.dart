import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_attendance/core/utils/media_query_values.dart';
import 'package:student_attendance/features/doctorhome/presentation/widgets/custom_student_attendance_widget.dart';

import '../bloc/dr_home_bloc.dart';

class AttendingStudentsPage extends StatefulWidget {
  const AttendingStudentsPage({Key? key}) : super(key: key);

  @override
  State<AttendingStudentsPage> createState() => _AttendingStudentsPageState();
}

class _AttendingStudentsPageState extends State<AttendingStudentsPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DrHomeBloc>(context).add(GetAttendingStudentsEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text('Attending students screen'),
      ),
      body: BlocBuilder<DrHomeBloc, DrHomeState>(
        builder: (context, state) {
          if (state is AttendingStudentsLoadingState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return _buildLoadingShimmer();
              },
              itemCount: 5,
            );
          } else if (state is AttendingStudentsSuccessState) {
            if (state.students.isEmpty) {
              return Center(child: Text('No Students attend yet'));
            } else
              return ListView.separated(
                itemCount: state.students.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  return CustomStudentAttendanceWidget(
                    student: state.students[index],
                  );
                },
              );
          } else if (state is AttendingStudentsErrorState) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return InkWell(
      onTap: () {},
      child: Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[100]!,
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
                    width: context.width * 0.5,
                    child: Container(
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: context.width * 0.2,
                    height: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 18,
              left: context.width * 0.70,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
