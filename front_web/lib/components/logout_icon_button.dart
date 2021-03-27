import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/screens/login/login_screen.dart';

class LogoutIcon extends StatefulWidget {
  LogoutIcon({Key key}) : super(key: key);

  @override
  _LogoutIconState createState() => _LogoutIconState();
}

class _LogoutIconState extends State<LogoutIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () {
        var st = GetStorage('local');
        st.remove('token');
        var storage = GetStorage('local');
        storage.write('cancel_g', true);
        setState(() {
          Navigator.pushNamed(context, LoginScreen.routeName);
        });
      },
    );
  }
}
