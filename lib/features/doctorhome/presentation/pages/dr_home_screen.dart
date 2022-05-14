import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_attendance/features/doctorhome/presentation/pages/attending_students_screen.dart';
import 'package:student_attendance/features/doctorhome/presentation/pages/qr_code_screen.dart';
import 'package:student_attendance/injector_container.dart';

class DrHomeScreen extends StatefulWidget {
  const DrHomeScreen({Key? key}) : super(key: key);

  @override
  State<DrHomeScreen> createState() => _DrHomeScreenState();
}

class _DrHomeScreenState extends State<DrHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr home screen'),
        actions: [
          TextButton(
            onPressed: () {
              sl<FirebaseAuth>().signOut();
            },
            child: Icon(
              Icons.login,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => QrCodeScreen(),
                    ),
                  );
                },
                child: Text('Generate QR Code'),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AttendingStudentsScreen()));
                },
                child: Text('Attending students'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
