import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/screens/welcome/background.dart';

import '../../widgets/round_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO ThriftNep",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.pushReplacementNamed(context, 'signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
