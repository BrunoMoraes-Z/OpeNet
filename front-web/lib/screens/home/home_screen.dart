import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:openet/utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void load() async {
      var dio = Dio();
      dio.options
        ..baseUrl = 'https://primeback.herokuapp.com/'
        ..headers = {
          'Referer': dio.options.baseUrl,
          HttpHeaders.userAgentHeader: 'dio',
          // 'User-Agent':
          // 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.57'
        };

      var response = await dio.get('/cep');
      print(response.data);
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.greenAccent,
                  Colors.lightGreenAccent,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.getProportionateScreenWidth(50),
                  right: SizeConfig.getProportionateScreenWidth(50),
                  top: SizeConfig.getProportionateScreenHeight(200),
                  bottom: SizeConfig.getProportionateScreenHeight(200),
                ),
                child: Container(
                  height: SizeConfig.screenHeight / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Color(0xffe0e0e0),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      SizeConfig.getProportionateScreenWidth(30),
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(Icons.lock),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            child: Text('Entrar'),
                            onPressed: () {
                              load();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
