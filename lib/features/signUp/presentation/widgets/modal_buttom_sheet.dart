import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_attendance/features/signUp/presentation/cubit/image_picker_cubit.dart';

Future<dynamic> customModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => Container(
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<ImagePickerCubit>(context)
                  .pickUserImage(ImageSource.gallery);
            },
            child: Text('from gallery'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

              BlocProvider.of<ImagePickerCubit>(context)
                  .pickUserImage(ImageSource.camera);
            },
            child: Text('from camera'),
          ),
        ],
      ),
    ),
  );
}
