import 'package:flutter/material.dart';

import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../injector_container.dart';
import '../routes/app_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.profilePage);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.settingsPage);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              sl<AuthenticationRepository>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
