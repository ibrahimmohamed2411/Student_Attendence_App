import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/custom_outlined_button.dart';
import '../bloc/signup_bloc.dart';

class LoadOrSignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  LoadOrSignUpButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if (state is Loading) {
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
