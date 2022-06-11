import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_attendance/features/settings/presentation/bloc/theme/theme_cubit.dart';

late String currentMode;

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, state) {
              return SwitchListTile(
                value: state,
                onChanged: BlocProvider.of<ThemeCubit>(context).toggleTheme,
                title: Text('Dark Mode'),
              );
            },
          ),
        ],
      ),
    );
  }
}
