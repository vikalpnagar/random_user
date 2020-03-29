import 'package:random_user/models/user.dart';
import 'package:random_user/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// User info to show on app drawer
class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 156.0,
      child: Consumer<UserProvider>(
        builder: (ctx, userProvider, _) => userProvider.user != null
            ? _buildUserInfo(context, userProvider.user)
            : Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
      ),
    );
  }

  Column _buildUserInfo(BuildContext context, User user) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildUserImage(user.picture.medium),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            user.name?.name ?? '--',
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      );

  /// Fetches and builds user image
  Align _buildUserImage(String url) => Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.0),
          child: FadeInImage(
            width: 64.0,
            placeholder: AssetImage('assets/images/photo_placeholder.png'),
            image: NetworkImage(url),
          ),
        ),
      );
}
