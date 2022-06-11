import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/authentication/presentation/widgets/modal_buttom_sheet.dart';
import 'package:student_attendance/features/profile/presentation/bloc/update_profile_bloc.dart';
import 'package:student_attendance/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:student_attendance/features/profile/presentation/cubit/update_user_photo_cubit.dart';

import '../../../../core/presentation/util/validators.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/utils/message_manager.dart';
import '../../../../injector_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late String imageUrl;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is UserProfileDataSuccessLoadedState) {
            nameController.text = state.profile.name;
            emailController.text = state.profile.email;
            passwordController.text = state.profile.password;
            imageUrl = state.profile.imageUrl;
            BlocProvider.of<UpdateUserPhotoCubit>(context, listen: false)
                .emit(imageUrl);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BlocBuilder<UpdateUserPhotoCubit, String?>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              profileModalBottomSheet(context: context);
                            },
                            child: ClipOval(
                              child: Image.network(
                                state!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        labelText: 'Name',
                        controller: nameController,
                        validator: nameValidator,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        labelText: 'Email',
                        controller: emailController,
                        validator: emailValidator,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      CustomTextField(
                        labelText: 'Password',
                        controller: passwordController,
                        validator: passwordValidator,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                        listenWhen: (previous, current) => previous != current,
                        listener: (_, state) {
                          if (state is UserProfileUpdatedSuccessState) {
                            sl<MessageManager>()
                                .showToastMessage(msg: state.msg);
                          } else if (state is UserProfileUpdatedErrorState) {
                            sl<MessageManager>()
                                .showToastMessage(msg: state.msg);
                          }
                        },
                        builder: (context, state) {
                          if (state is UserProfileUpdateLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<UpdateProfileBloc>(context).add(
                                UpdateUserProfileEvent(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  imageUrl: imageUrl,
                                ),
                              );
                            },
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is UserProfileErrorState) {
            return Center(
              child: Text(
                state.msg,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
