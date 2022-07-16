import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/enums/role.dart';
import '../../../../../injector_container.dart';
import '../../../../doctorhome/presentation/pages/dr_home_page.dart';
import '../../../../studenthome/presentation/pages/student_home_page.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../signIn/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: sl<AuthenticationRepository>().autoStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<DocumentSnapshot>(
            stream: sl<AuthenticationRepository>().userRoleChanges(),
            builder: (ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                bool exist = snapshot.data!.exists;
                if (exist) {
                  final role = snapshot.data!['role'];
                  if (role == Role.student.name) {
                    return StudentHomePage();
                  } else {
                    return DrHomePage();
                  }
                }
              }

              return Scaffold(
                body: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              );
            },
          );
        }

        return SignInPage();
      },
    );
  }
}
