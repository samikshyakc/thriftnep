import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/provider/cart_provider.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {

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
                    image: AssetImage('background.png'),
                    fit: BoxFit.cover),
                // gradient: LinearGradient(
                //   //  colors: [kPrimaryColor, Colors.blue[300]],
                //
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter)
        ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Text(
                    'Thank you!!!!',
                    style: TextStyle(
                        fontFamily: 'Camar', color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your order has been placed.',
                    style: TextStyle(
                        fontFamily: 'Camar', color: Colors.white, fontSize: 40),
                  ),
                  Container(
                    height: 260,
                  ),
                  SizedBox(
                    height: 15,
                  ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'home');
                },
                child: Text(
                  'Take me to home screen',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
            )));
  }

  startTime() async {
    var duration = new Duration(seconds: 15);
    return new Timer(duration, goToAnotherScreen);
  }

  goToAnotherScreen() async {
    await Future.delayed(Duration(seconds: 20), () {
      Navigator.pushReplacementNamed(context, 'home');
    });
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
