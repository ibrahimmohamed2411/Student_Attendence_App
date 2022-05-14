import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/presentation/util/validators.dart';
import 'package:student_attendance/core/presentation/widgets/custom_text_field.dart';
import 'package:student_attendance/features/signIn/presentation/bloc/signin/sign_in_cubit.dart';
import 'package:student_attendance/features/signIn/presentation/widgets/loading_or_build_sign_in_button.dart';
import 'package:student_attendance/features/signUp/presentation/pages/sign_up_screen.dart';

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
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(0, 90, 0, 30),
        child: SingleChildScrollView(
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                BlocListener<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is Error) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Failed',
                        desc: state.msg,
                        btnOkOnPress: () {
                          // Navigator.of(context).pop();
                        },
                      )..show();
                    }
                  },
                  child: SizedBox(),
                ),
                CustomTextField(
                  labelText: 'Email',
                  validator: emailValidator,
                  controller: emailController,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Password',
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
                      BlocProvider.of<SignInCubit>(context)
                          .signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpScreen()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
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
