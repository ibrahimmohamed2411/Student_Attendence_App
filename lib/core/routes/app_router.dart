import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/pages/landingPage/landing_page.dart';
import 'package:student_attendance/features/authentication/presentation/pages/signUp/sign_up_page.dart';
import 'package:student_attendance/features/doctorhome/presentation/pages/attending_students_page.dart';
import 'package:student_attendance/features/doctorhome/presentation/pages/qr_code_page.dart';
import 'package:student_attendance/features/settings/presentation/pages/settings_page.dart';
import 'package:student_attendance/features/studenthome/presentation/pages/student_home_page.dart';

import '../../features/authentication/presentation/bloc/cubit/image_picker_cubit.dart';
import '../../features/doctorhome/presentation/bloc/dr_home_bloc.dart';
import '../../features/doctorhome/presentation/pages/dr_home_page.dart';
import '../../features/studenthome/presentation/bloc/qr_cubit.dart';
import '../../features/studenthome/presentation/pages/qr_scanner_screen.dart';
import '../../injector_container.dart';

final doctorHomeBloc = sl<DrHomeBloc>();

class AppRouter {
  static const String landingPage = '/';
  static const String signUpPage = '/sign-up-page';
  static const String drHomePage = '/doctor-home-page';
  static const String qrCodePage = '/qr-code-page';
  static const String attendingStudentsPage = '/attending-students-page';
  static const String studentHomePage = '/student-home-page';
  static const String settingsPage = '/settings-page';
  static const String qrScannerPage = '/qr-scanner-page';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingPage:
        return MaterialPageRoute(
          builder: (context) => LandingPage(),
        );
      case signUpPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<ImagePickerCubit>(),
            child: SignUpPage(),
          ),
        );
      case drHomePage:
        return MaterialPageRoute(
          builder: (context) => DrHomePage(),
        );
      case studentHomePage:
        return MaterialPageRoute(
          builder: (context) => StudentHomePage(),
        );
      case attendingStudentsPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: doctorHomeBloc..add(GetAttendingStudentsEvent()),
            child: AttendingStudentsPage(),
          ),
        );
      case qrCodePage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: doctorHomeBloc..add(GenerateQrCodeEvent()),
            child: QrCodePage(),
          ),
        );
      case settingsPage:
        return MaterialPageRoute(
          builder: (context) => SettingsPage(),
        );
      case qrScannerPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<QrCubit>(),
            child: QrScannerScreen(),
          ),
        );
    }
    return null;
  }

  Future<void> dispose() async {
    return doctorHomeBloc.close();
  }
}
