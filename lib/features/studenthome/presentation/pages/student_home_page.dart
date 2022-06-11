import 'package:flutter/material.dart';
import 'package:student_attendance/core/routes/app_router.dart';

import '../../../../core/widgets/custom_drawer.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Student Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouter.qrScannerPage);
              },
              child: Text('Scan Qr Code'),
            ),
          ],
        ),
      ),
    );
  }
}
