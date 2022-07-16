import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../core/presentation/widgets/custom_outlined_button.dart';

class LoadOrSignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  LoadOrSignUpButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is SignUpLoadingState) {
          return Text(
            'Please Wait...',
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return CustomOutlinedButton(
          onPressed: onPressed,
          label: 'Sign Up',
        );
      },
    );
  }
}
