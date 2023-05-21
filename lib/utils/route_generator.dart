import 'package:flutter/material.dart';
import 'package:gallery/pages/authentication_screen.dart';
import 'package:gallery/pages/verify_phone_number_screen.dart';
import 'package:gallery/utils/helpers.dart';

import '../pages/home.dart';

class RouteGenerator {
  static const _id = 'RouteGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings, Widget home) {
    final args = settings.arguments as dynamic;
    log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case AuthenticationScreen.id:
        return _route(const AuthenticationScreen());
      case VerifyPhoneNumberScreen.id:
        return _route(VerifyPhoneNumberScreen(phoneNumber: args));
      case HomePage.id:        
        return _route(home);
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('ROUTE \n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
