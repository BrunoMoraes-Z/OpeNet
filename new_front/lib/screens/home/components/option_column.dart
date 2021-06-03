import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openet/screens/home/components/panels/cadastros_dash.dart';
import 'package:openet/screens/home/components/panels/home_dash.dart';
import 'package:openet/screens/home/components/option_row.dart';
import 'package:openet/screens/home/controller/home_controller.dart';
import 'package:openet/screens/login/login_screen.dart';
import 'package:openet/utils/my_toast.dart';

class OptionColumn extends StatelessWidget {
  const OptionColumn({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    var st = GetStorage('local');
    st.write('home', 'home');
    return Expanded(
      child: SizedBox(
        width: 300,
        height: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                OptionRow(
                  icon: Icons.home,
                  text: 'Home',
                  press: () {
                    if (st.read('home') != 'home') {
                      controller.content = HomeDashBoard();
                      st.write('home', 'home');
                    }
                  },
                ),
                if (st.hasData('admin'))
                  OptionRow(
                    icon: Icons.people,
                    text: 'Cadastros Pentendes',
                    press: () {
                      if (st.read('home') != 'pending') {
                        controller.content = CadastrosPendentesDashBoard();
                        st.write('home', 'pending');
                      }
                    },
                  ),
              ],
            ),
            Spacer(),
            OptionRow(
              icon: Icons.logout,
              text: 'Sair',
              press: () {
                MyToast.showSucess('Logout realizado com sucesso');
                Navigator.popAndPushNamed(context, LoginScreen.routeName);
              },
            ),
            SizedBox(
              height: 60,
              child: Text.rich(
                TextSpan(
                  text: 'OpeNet Network ',
                  children: [
                    TextSpan(
                      text: '2021',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
