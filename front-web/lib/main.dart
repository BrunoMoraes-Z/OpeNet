import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/screens/splash/splash_screen.dart';
import 'package:openet/utils/routes.dart';

void main() async {
  await GetStorage.init('local');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'OpeNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: kIsWeb ? LoginScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}
