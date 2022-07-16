import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/presentation/util/validators.dart';
import 'package:student_attendance/core/presentation/widgets/custom_text_field.dart';
import 'package:student_attendance/core/presentation/widgets/password_form_field.dart';
import 'package:student_attendance/core/routes/app_router.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/widgets/loading_or_build_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var _fromKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          margin: EdgeInsets.fromLTRB(0, 160, 0, 30),
          child: Form(
            key: _fromKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is SignInErrorState) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Failed',
                        desc: state.msg,
                        btnOkOnPress: () {},
                      )..show();
                    }
                  },
                  child: SizedBox(),
                ),
                CustomTextField(
                  labelText: 'Email',
                  validator: emailValidator,
                  textInputType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                SizedBox(
                  height: 20,
                ),
                PasswordFormField(
                  //  label: 'Password',
                  validator: passwordValidator,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 30,
                ),
                LoadingOrBuildSignInButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_fromKey.currentState!.validate()) {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SignInEvent(
                          password: passwordController.text,
                          email: emailController.text,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouter.signUpPage);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
