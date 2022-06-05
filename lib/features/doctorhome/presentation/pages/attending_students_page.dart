import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return Center(child: CircularProgressIndicator());
          } else if (state is AttendingStudentsSuccessState) {
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
                      state.students[index].attendancePercentage.toString(),
                    ),
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
}
