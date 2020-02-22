import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  final User _user;

  const UserDetail(this._user);

  @override
  Widget build(BuildContext context) {
    return _buildUserInfoView(context);
  }

  Widget _buildUserInfoView(BuildContext context) => Scrollbar(
          child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _buildUserImage(_user.picture.large),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).nameLabel),
              subtitle:
                  _buildListSubtitleText(context, _user.name?.name ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).genderLabel),
              subtitle: _buildListSubtitleText(context, _user.gender ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).emailLabel),
              subtitle: _buildListSubtitleText(context, _user.email ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).phoneLabel),
              subtitle: _buildListSubtitleText(context, _user.phone ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).cellLabel),
              subtitle: _buildListSubtitleText(context, _user.cell ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).dobLabel),
              subtitle: _buildListSubtitleText(
                  context, _user.dob?.dateTimeWithAge ?? '--'),
            ),
          ),
          Card(
            color: Theme.of(context).accentColor,
            child: ListTile(
              title: _buildListTitleText(
                  context, AppLocalizations.of(context).addressLabel),
              subtitle: _buildListSubtitleText(
                  context, _user.location?.address ?? '--'),
            ),
          ),
        ],
      ));

  Widget _buildUserImage(String url) => Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64.0),
          child: FadeInImage(
            width: 128.0,
            placeholder: AssetImage('assets/images/photo_placeholder.png'),
            image: NetworkImage(url),
          ),
        ),
      );

  Text _buildListTitleText(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.title,
      );

  Text _buildListSubtitleText(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.subtitle,
      );
}
