import 'package:flutter/material.dart';
import 'package:flutter_login/models/language_constants.dart';
import 'package:flutter_login/main.dart';
import 'package:flutter_login/regex/validate.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

// ignore: unnecessary_new
TextEditingController _controller = new TextEditingController();
// ignore: unnecessary_new
TextEditingController _controller2 = new TextEditingController();
bool isEmailValid = false;

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String name = '';

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
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(60, 60),
                bottomRight: Radius.elliptical(60, 60)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(
                Icons.person,
                size: 90,
              ),
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
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                translation(context).sing_in_continune,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              inputForm(translation(context).email, _controller),
              const SizedBox(
                height: 20,
              ),
              inputForm(translation(context).password, _controller2,
                  obscureText: true),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                onTap: (){
                  DialogHelper.showSuccessDialog(context, "Not Yet", "No action available at this time");
                },                  
                child: Text(
                  translation(context).forgot_password,
                  style: const TextStyle(color: Colors.indigoAccent),
                )
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MaterialButton(
                  child: Container(
                    width: 300,
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
                  onPressed: () {
                    String email =
                        _controller.text; // Email değerini almak için
                    String password =
                        _controller2.text; // Şifre değerini almak için

                    if (!isEmailValid || password.isEmpty) {
                      DialogHelper.showSuccessDialog(
                          context,
                          translation(context).error_header,
                          translation(context).error_mail_or_password);

                      return;
                    } else if (email == "ferhatblt367@gmail.com" &&
                        password == "123456") {
                      DialogHelper.showSuccessDialog(
                          context,
                          translation(context).success,
                          translation(context).success_login);
                    } else {
                      DialogHelper.showSuccessDialog(
                          context,
                          translation(context).unsuccess,
                          translation(context).unsuccess_login);
                    }
                  }),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translation(context).new_user),
                  Text(
                    translation(context).sign_up,
                    style: const TextStyle(color: Colors.indigoAccent),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget inputForm(String title, TextEditingController controller,
      {bool obscureText = false}) {
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
                            : Colors.redAccent)
                : Border.all(width: 0.5, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: const InputDecoration(border: InputBorder.none),
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
