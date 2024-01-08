import 'package:flutter/material.dart';
import 'package:flutter_login/models/language_constants.dart';
import 'package:flutter_login/models/languages.dart';
import 'package:flutter_login/main.dart';
import 'package:flutter_login/regex/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

TextEditingController _controller = new TextEditingController();
TextEditingController _controller2 = new TextEditingController();
bool isEmailValid = false;

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String name = '';

  void _showSuccessDialog(String user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translation(context).welcome),
          content: Text(translation(context).hello_user(user)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(60, 60),
                bottomRight: Radius.elliptical(60, 60)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0, left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 50,
                  ),
                  onChanged: (Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      Flutter_Login.setLocale(context, _locale);
                    }
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation(context).welcome,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                translation(context).sing_in_continune,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              inputForm(translation(context).email, _controller),
              const SizedBox(
                height: 20,
              ),
              inputForm(translation(context).password, _controller2),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  translation(context).forgot_password,
                  style: TextStyle(color: Colors.indigoAccent),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      translation(context).login,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translation(context).new_user),
                  Text(
                    translation(context).sign_up,
                    style: TextStyle(color: Colors.indigoAccent),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget inputForm(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: title == translation(context).email
                ? Border.all(
                    width: 0.5,
                    color: controller.text.isEmpty
                        ? Colors.grey
                        : isEmailValid
                            ? Colors.green
                            : Colors.red)
                : Border.all(width: 0.5, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: (value) {
                if (title == translation(context).email) {
                  if (value.isEmpty) {
                    setState(() {
                      isEmailValid = true;
                    });
                  } else {
                    final isValid = validateEmailAddress(value);
                    if (isValid) {
                      setState(() {
                        isEmailValid = true;
                      });
                    } else {
                      setState(() {
                        isEmailValid = false;
                      });
                    }
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
