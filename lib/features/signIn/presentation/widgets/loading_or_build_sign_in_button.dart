import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/custom_outlined_button.dart';
import '../bloc/signin/sign_in_cubit.dart';

class LoadingOrBuildSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LoadingOrBuildSignInButton({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
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
