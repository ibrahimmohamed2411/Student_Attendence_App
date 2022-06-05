import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/core/presentation/util/validators.dart';
import 'package:student_attendance/features/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../../core/enums/gender.dart';
import '../../../../../core/enums/role.dart';
import '../../../../../core/presentation/widgets/custom_text_field.dart';
import '../../bloc/cubit/image_picker_cubit.dart';
import '../../widgets/load_or_sign_up_button.dart';
import '../../widgets/modal_buttom_sheet.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  Gender? gender = Gender.male;
  Role? role = Role.student;

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
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Success',
                        desc: 'Your email has been created',
                        btnOkOnPress: () {
                          Navigator.of(context).pop();
                        },
                      )..show();
                    } else if (state is SignUpErrorState) {
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
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  validator: emailValidator,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  validator: passwordValidator,
                  obscureText: true,
                ),
                _buildGenderWidget(),
                _buildRoleWidget(),
                SizedBox(
                  height: 20,
                ),
                LoadOrSignUpButton(
                  onPressed: () {
                    File? image =
                        BlocProvider.of<ImagePickerCubit>(context).state;
                    if (image != null) {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          SignUpEvent(
                              name: nameController.text,
                              role: role!,
                              email: emailController.text,
                              password: passwordController.text,
                              image: BlocProvider.of<ImagePickerCubit>(context)
                                  .state!,
                              gender: gender!),
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

  Row _buildRoleWidget() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<Role>(
            title: Text('Student'),
            value: Role.student,
            groupValue: role,
            onChanged: (v) {
              setState(() {
                role = v;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Role>(
            title: Text('Doctor'),
            value: Role.doctor,
            groupValue: role,
            onChanged: (v) {
              setState(() {
                role = v;
              });
            },
          ),
        ),
      ],
    );
  }

  Row _buildGenderWidget() {
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
