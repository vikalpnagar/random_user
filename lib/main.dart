import 'dart:io';

import 'package:random_user/app/app_localizations.dart';
import 'package:random_user/providers/user_provider.dart';
import 'package:random_user/screens/home_screen.dart';
import 'package:random_user/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';

void main() => runApp(RandomUserApp());

class RandomUserApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IOClient>(
          create: (_) => _createIOClient(),
        ),
        ChangeNotifierProxyProvider<IOClient, UserProvider>(
          create: (_) => UserProvider(),
          update: (ctx, ioClient, userProvider) {
            return userProvider..ioClient = ioClient;
          },
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
        supportedLocales: [
          const Locale('en'),
        ],
        localizationsDelegates: [
          const AppTranslationsDelegate(),
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
          //provides IOS localization
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: _buildThemeData(),
        home: HomeScreen(),
        routes: {
          MapScreen.routeName: (ctx) => MapScreen(),
        },
      ),
    );
  }

  ThemeData _buildThemeData() => ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.cyan,
    fontFamily: 'OpenSans',
    textTheme: ThemeData.light().textTheme.copyWith(
      title: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 18,
      ),
      subtitle: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        color: Colors.white,
      ),
      button: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      subhead: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
      ),
      body1: const TextStyle(),
      caption: const TextStyle(),
    ),
    buttonTheme: ThemeData.light().buttonTheme.copyWith(
      buttonColor: Colors.cyan,
    ),
    appBarTheme: AppBarTheme(
      textTheme: ThemeData.light().textTheme.copyWith(
        title: const TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
        ),
      ),
    ),
  );

  IOClient _createIOClient() {
    final httpClient = HttpClient();
    httpClient.connectionTimeout = const Duration(seconds: 10);
    return IOClient(httpClient);
  }
}
