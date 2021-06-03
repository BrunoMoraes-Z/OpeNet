import 'package:flutter/material.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/recover/recover_screen.dart';
import 'package:openet/screens/register/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RecoverScreen.routeName: (context) => RecoverScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
