import 'package:flutter/material.dart';
import 'package:flutter_login/pages/login_page.dart';
import 'package:flutter_login/pages/not_found_page.dart';
import 'package:flutter_login/router/route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
         return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}