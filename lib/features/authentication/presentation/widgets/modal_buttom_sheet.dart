import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../profile/presentation/cubit/update_user_photo_cubit.dart';
import '../bloc/cubit/image_picker_cubit.dart';

Future<dynamic> signUpModalBottomSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => Container(
      padding: EdgeInsets.all(10),
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<ImagePickerCubit>(context)
                    .pickUserImage(ImageSource.camera);
              },
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Icon(Icons.camera_alt,
                        color: Theme.of(context).primaryColor, size: 80),
                    Text(
                      'From Camera',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<ImagePickerCubit>(context)
                    .pickUserImage(ImageSource.gallery);
              },
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Icon(
                      Icons.photo_camera_back,
                      color: Theme.of(context).primaryColor,
                      size: 80,
                    ),
                    Text(
                      'From Gallery',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Future<dynamic> profileModalBottomSheet({required BuildContext context}) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => Container(
      padding: EdgeInsets.all(10),
      height: 180,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                BlocProvider.of<UpdateUserPhotoCubit>(context)
                    .pickUserImage(ImageSource.camera);
              },
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Icon(Icons.camera_alt,
                        color: Theme.of(context).primaryColor, size: 100),
                    Text(
                      'From Camera',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();

                BlocProvider.of<UpdateUserPhotoCubit>(context)
                    .pickUserImage(ImageSource.gallery);
              },
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Icon(Icons.photo_camera_back,
                        color: Theme.of(context).primaryColor, size: 100),
                    Text(
                      'From Gallery',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
