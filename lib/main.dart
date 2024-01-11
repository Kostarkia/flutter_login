import 'package:flutter/material.dart';
import 'package:flutter_login/models/language_constants.dart';
import 'package:flutter_login/router/custom_router.dart';
import 'package:flutter_login/router/route_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const Flutter_Login());
}

// ignore: camel_case_types
class Flutter_Login extends StatefulWidget {
  const Flutter_Login({Key? key}) : super(key: key);

  @override
  State<Flutter_Login> createState() => _Flutter_LoginState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _Flutter_LoginState? state =
        context.findAncestorStateOfType<_Flutter_LoginState>();
    state?.setLocale(newLocale);
  }
}

// ignore: unused_element
class DialogHelper {
  static void showSuccessDialog(
      BuildContext context, String header, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(header),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dialogu kapat
              },
              child: Text(translation(context).close),
            ),
          ],
        );
      },
    );
  }
}

// ignore: camel_case_types
class _Flutter_LoginState extends State<Flutter_Login> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: CustomRouter.generatedRoute,
      initialRoute: homeRoute,
      locale: _locale,
    );
  }
}
