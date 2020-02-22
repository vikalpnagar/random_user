import 'dart:async';
import 'dart:ui';

import 'package:random_user/l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final String _localeName;

  AppLocalizations(this._localeName) {}

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return AppLocalizations(localeName);
    });
  }

  String get appTitle =>
      Intl.message("Random User", name: "appTitle", locale: _localeName);

  String get homeTitle =>
      Intl.message("Random User", name: "homeTitle", locale: _localeName);

  String get mapTitle =>
      Intl.message("Map", name: "mapTitle", locale: _localeName);

  String get noDataToShow =>
      Intl.message("Nothing to show here.\nTry refreshing the page.",
          name: "noDataToShow", locale: _localeName);

  String get refreshButton =>
      Intl.message("Refresh", name: "refreshButton", locale: _localeName);

  String get errorDialogTitle => Intl.message("An error occurred!",
      name: "errorDialogTitle", locale: _localeName);

  String get errorDialogMsg => Intl.message("Something went wrong.",
      name: "errorDialogMsg", locale: _localeName);

  String get errorDialogMsgNoInternet =>
      Intl.message("Looks like you do not have active internet connection.",
          name: "errorDialogMsgNoInternet", locale: _localeName);

  String get errorDialogButton =>
      Intl.message("Okay", name: "errorDialogButton", locale: _localeName);

  String get nameLabel =>
      Intl.message("Name", name: "nameLabel", locale: _localeName);

  String get genderLabel =>
      Intl.message("Gender", name: "genderLabel", locale: _localeName);

  String get emailLabel =>
      Intl.message("Email", name: "emailLabel", locale: _localeName);

  String get phoneLabel =>
      Intl.message("Phone", name: "phoneLabel", locale: _localeName);

  String get cellLabel =>
      Intl.message("Cell", name: "cellLabel", locale: _localeName);

  String get dobLabel =>
      Intl.message("DOB", name: "dobLabel", locale: _localeName);

  String get addressLabel =>
      Intl.message("Address", name: "addressLabel", locale: _localeName);

  String get currentLocation =>
      Intl.message("Currently, You are here!!!", name: "currentLocation", locale: _localeName);
}

class AppTranslationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppTranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
