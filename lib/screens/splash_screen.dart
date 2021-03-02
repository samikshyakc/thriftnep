import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {


    Provider.of<EmailProvider>(context).getEmail();
   // String email = Provider.of<EmailProvider>(context, listen: false).email();
    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        kAppbar.withOpacity(1.0), BlendMode.darken),
                    image: AssetImage('1.png'), fit: BoxFit.cover),
                gradient: LinearGradient(
                  colors: [kPrimaryColor, Colors.blue[300]],

                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)
    ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    'THRIFT NEP',
                    style: TextStyle(
                        fontFamily: 'Camar', color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 260,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'REUSE, SAVE ENVIRONMENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  LinearPercentIndicator(
                    alignment: MainAxisAlignment.center,
                    width: 240.0,
                    lineHeight: 4.0,
                    animation: true,
                    percent: 1.0,
                    animationDuration: 2250,
                    backgroundColor: Colors.grey,
                    progressColor: Colors.white,
                  ),
                ],
              ),
            )));
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, goToAnotherScreen);
  }

  goToAnotherScreen() async {
    String email = Provider.of<EmailProvider>(context, listen: false).email();
    print(email);
    if (email.isEmpty) {
      await Future.delayed(Duration(seconds: 1), () {
        //go to welcome screen
        Navigator.pushReplacementNamed(context, 'welcome');
      });
    } else {
      //go to home page
      await Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, 'home');
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // goToAnotherScreen();
    startTime();
    //getEmail();
  }

  // getEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //Return String
  //   email = prefs.getString('email') ?? '';
  //   //return email = await getValue() ?? "";
  //   //return email;
  // }
}
