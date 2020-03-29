import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/screens/map_screen.dart';
import 'package:random_user/widget/user_info.dart';
import 'package:flutter/material.dart';

/// An app drawer for the application
class AppDrawer extends StatelessWidget {
  static const int HOME_POS = 1;
  static const int MAP_POS = 2;

  final int currentPosition;

  const AppDrawer(this.currentPosition);

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

  /// Build ListTile for HomeScreen
  ListTile _buildHomeListTile(BuildContext context) => ListTile(
        leading: Icon(
          Icons.supervised_user_circle,
          color: _getIconColorByPos(context, HOME_POS),
        ),
        title: Text(
          AppLocalizations.of(context).homeTitle,
          style: _buildTextStyleByPos(context, HOME_POS),
        ),
        onTap: () {
          isSelected(HOME_POS)
              ? Navigator.of(context).pop()
              : Navigator.of(context).pushReplacementNamed('/');
        },
      );

  /// Build ListTile for MapScreen
  ListTile _buildMapListTile(BuildContext context) => ListTile(
        leading: Icon(
          Icons.map,
          color: _getIconColorByPos(context, MAP_POS),
        ),
        title: Text(
          AppLocalizations.of(context).mapTitle,
          style: _buildTextStyleByPos(context, MAP_POS),
        ),
        onTap: () {
          isSelected(MAP_POS)
              ? Navigator.of(context).pop()
              : Navigator.of(context).pushReplacementNamed(MapScreen.routeName);
        },
      );

  /// Generate icon color based on currently selected item in drawer
  Color _getIconColorByPos(BuildContext context, int pos) => isSelected(pos)
      ? Theme.of(context).primaryColor
      : Theme.of(context).iconTheme.color;

  /// Generate TextStyle based on currently selected item in drawer
  TextStyle _buildTextStyleByPos(BuildContext context, int pos) => TextStyle(
      color: isSelected(pos)
          ? Theme.of(context).primaryColor
          : Theme.of(context).textTheme.title.color);

  bool isSelected(int pos) => currentPosition == pos;
}
