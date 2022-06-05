import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../core/presentation/widgets/custom_outlined_button.dart';

class LoadingOrBuildSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LoadingOrBuildSignInButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is SignInLoadingState) {
          return CircularProgressIndicator();
        }
        return CustomOutlinedButton(
          onPressed: onPressed,
          label: 'Sign In',
        );
      },
    );
  }
}
