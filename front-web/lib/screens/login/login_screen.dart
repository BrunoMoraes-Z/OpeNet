import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/utils/size_config.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final st = GetStorage('local');
    print('Has Token: ${st.hasData('token')}');

    return Scaffold(
      body: Container(
        color: Color(0xfff0f0f5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: SizeConfig.screenWidth / 2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 140,
                  right: 140,
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: !_passwordVisible,
                        // obscuringCharacter: '*',
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () => print('Click'),
                        child: Container(
                          height: 45,
                          width: 160,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff28a745),
                                Color(0xff20c997),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: SvgPicture.asset(
                    '/logo_web.svg',
                    width: (SizeConfig.screenWidth / 2) - 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
