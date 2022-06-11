import 'package:flutter/material.dart';
import 'package:student_attendance/core/routes/app_router.dart';
import 'package:student_attendance/core/widgets/custom_drawer.dart';

class DrHomePage extends StatefulWidget {
  const DrHomePage({Key? key}) : super(key: key);

  @override
  State<DrHomePage> createState() => _DrHomePageState();
}

class _DrHomePageState extends State<DrHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Dr home screen'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouter.qrCodePage);
                },
                child: Text('Generate QR Code'),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRouter.attendingStudentsPage);
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
