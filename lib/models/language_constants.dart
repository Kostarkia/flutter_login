import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
const String LANGUAGE_CODE = 'languageCode';

//languages code
// ignore: constant_identifier_names
const String TURKISH = 'tr';
// ignore: constant_identifier_names
const String ENGLISH = 'en';

Future<Locale> setLocale(String languageCode) async {
  // ignore: no_leading_underscores_for_local_identifiers
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  // ignore: no_leading_underscores_for_local_identifiers
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case TURKISH:
      return const Locale(TURKISH, '');
    case ENGLISH:
      return const Locale(ENGLISH, '');
    default:
      return const Locale(TURKISH, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
