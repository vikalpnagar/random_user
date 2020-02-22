import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/helper/network_util.dart';
import 'package:random_user/providers/user_provider.dart';
import 'package:random_user/widget/app_drawer.dart';
import 'package:random_user/widget/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _futureFetchNewUser;

  @override
  void initState() {
    super.initState();
    _futureFetchNewUser = _fetchNewUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          AppLocalizations.of(context).homeTitle,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _futureFetchNewUser = _fetchNewUser();
              });
            },
            tooltip: AppLocalizations.of(context).refreshButton,
          ),
        ],
      );

  FutureBuilder _buildBody() => FutureBuilder(
      future: _futureFetchNewUser,
      builder: (ctx, snapshot) {
        bool waiting = snapshot.connectionState == ConnectionState.waiting;
        return RefreshIndicator(
          onRefresh: _fetchNewUser,
          child: Consumer<UserProvider>(
            builder: (ctx, userInfo, _) {
              return Stack(
                children: <Widget>[
                  userInfo.user != null
                      ? UserDetail(userInfo.user)
                      : SizedBox.shrink(),
                  waiting
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : (userInfo.user == null
                          ? _buildNoDataView()
                          : SizedBox.shrink())
                ],
              );
            },
          ),
        );
      });

  Center _buildNoDataView() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).noDataToShow,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            RaisedButton(
              onPressed: () => setState(() {
                _futureFetchNewUser = _fetchNewUser();
              }),
              child: Text(
                AppLocalizations.of(context).refreshButton,
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      );

  Future<void> _fetchNewUser() {
    var fetchNewUser =
        Provider.of<UserProvider>(context, listen: false).fetchNewUser();
    return fetchNewUser.catchError((error) async {
      if (mounted)
        await NetworkUtil.isActiveInternetAvailable().then((available) {
          showErrorDialog(!available);
        });
    });
  }

  void showErrorDialog(bool noInternet) {
    var appLocalizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(appLocalizations.errorDialogTitle),
        content: Text(noInternet
            ? appLocalizations.errorDialogMsgNoInternet
            : appLocalizations.errorDialogMsg),
        actions: <Widget>[
          FlatButton(
            child: Text(appLocalizations.errorDialogButton),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
