import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/utils/routes.dart';

void main() async {
  await GetStorage.init('local');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpeNet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: GoogleFonts.koHo().fontFamily,
      ),
      routes: routes,
      initialRoute: LoginScreen.routeName,
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (_) => Body());
      // },
    );
  }
}
