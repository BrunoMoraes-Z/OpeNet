import 'package:flutter/cupertino.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/registration/register_screen.dart';
import 'package:openet/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
