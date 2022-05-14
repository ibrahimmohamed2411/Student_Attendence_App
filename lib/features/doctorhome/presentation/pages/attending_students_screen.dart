import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/doctorhome/presentation/cubit/get_attending_students_cubit.dart';

import '../../../../injector_container.dart';

class AttendingStudentsScreen extends StatefulWidget {
  const AttendingStudentsScreen({Key? key}) : super(key: key);

  @override
  State<AttendingStudentsScreen> createState() =>
      _AttendingStudentsScreenState();
}

class _AttendingStudentsScreenState extends State<AttendingStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetAttendingStudentsCubit>()..getAttendance(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attending students screen'),
        ),
        body: BlocBuilder<GetAttendingStudentsCubit, GetAttendingStudentsState>(
          builder: (context, state) {
            if (state is Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              if (state.students.isEmpty) {
                return Center(child: Text('No Students attend yet'));
              } else
                return ListView.builder(
                  itemCount: state.students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(20),
                      leading: Image.network(
                        state.students[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                      title: Text(state.students[index].name),
                      subtitle: Text(
                        state.students[index].numOfAttendenceLectures
                            .toString(),
                      ),
                    );
                  },
                );
            } else if (state is Error) {
              return Center(child: Text(state.message));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
