import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/presentation/util/validators.dart';
import 'package:student_attendance/features/signUp/presentation/bloc/signup_bloc.dart';
import 'package:student_attendance/features/signUp/presentation/cubit/image_picker_cubit.dart';

import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../widgets/load_or_sign_up_button.dart';
import '../widgets/modal_buttom_sheet.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Gender? gender = Gender.male;
  Type? type = Type.student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up screen'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is SignUpSuccess) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Success',
                        desc: 'Your email has been created',
                        btnOkOnPress: () {
                          // Navigator.of(context).pop();
                        },
                      )..show();
                    } else if (state is Error) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Failed',
                        desc: state.message,
                        btnOkOnPress: () {
                          // Navigator.of(context).pop();
                        },
                      )..show();
                    }
                  },
                  child: SizedBox(),
                ),
                InkWell(
                  onTap: () {
                    customModalBottomSheet(context);
                  },
                  child: BlocBuilder<ImagePickerCubit, File?>(
                    builder: (context, state) {
                      if (state == null) {
                        return CircleAvatar(
                          radius: 70,
                        );
                      }
                      return ClipOval(
                        child: Image.file(
                          state,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Name',
                  controller: nameController,
                  validator: nameValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  validator: passwordValidator,
                ),
                buildGenderWidget(),
                buildTypeWidget(),
                SizedBox(
                  height: 20,
                ),
                LoadOrSignUpButton(
                  onPressed: () {
                    File? image =
                        BlocProvider.of<ImagePickerCubit>(context).state;
                    if (image != null) {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(
                              SignUp(
                                params: Params(
                                  type: type!,
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                  gender: gender!,
                                  email: emailController.text.trim(),
                                  image:
                                      BlocProvider.of<ImagePickerCubit>(context)
                                          .state!,
                                ),
                              ),
                            );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please choose your photo'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTypeWidget() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Type>(
            title: Text('Student'),
            value: Type.student,
            groupValue: type,
            onChanged: (v) {
              setState(() {
                type = v;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Type>(
            title: Text('Doctor'),
            value: Type.doctor,
            groupValue: type,
            onChanged: (v) {
              setState(() {
                type = v;
              });
            },
          ),
        ),
      ],
    );
  }

  Row buildGenderWidget() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Gender>(
            title: Text('Male'),
            value: Gender.male,
            groupValue: gender,
            onChanged: (v) {
              setState(() {
                gender = v;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Gender>(
            title: Text('Female'),
            value: Gender.female,
            groupValue: gender,
            onChanged: (v) {
              setState(() {
                gender = v;
              });
            },
          ),
        ),
      ],
    );
  }
}
