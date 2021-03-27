import 'package:flutter/cupertino.dart';
import 'package:openet/screens/complete_register/complete_register.dart';
import 'package:openet/screens/home/home_screen.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/recover/recover_screen.dart';
import 'package:openet/screens/registration/register_screen.dart';
import 'package:openet/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  CompleteRegister.routeName: (context) => CompleteRegister(),
  RecoverScreen.routeName: (context) => RecoverScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
