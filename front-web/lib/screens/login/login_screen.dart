import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final st = GetStorage('local');
    print('Has Token: ${st.hasData('token')}');

    return Scaffold();
  }
}
