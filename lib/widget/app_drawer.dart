import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/screens/map_screen.dart';
import 'package:random_user/widget/user_info.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserInfo(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                _buildHomeListTile(context),
                const Divider(),
                _buildMapListTile(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildHomeListTile(BuildContext context) => ListTile(
        leading: const Icon(Icons.supervised_user_circle),
        title: Text(AppLocalizations.of(context).homeTitle),
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/');
        },
      );

  ListTile _buildMapListTile(BuildContext context) => ListTile(
        leading: const Icon(Icons.map),
        title: Text(AppLocalizations.of(context).mapTitle),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(MapScreen.routeName);
        },
      );
}
