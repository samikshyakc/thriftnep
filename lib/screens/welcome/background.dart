import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(

          image: DecorationImage(image: AssetImage('1.png'), fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  kAppbar.withOpacity(1.0), BlendMode.darken)),

          gradient: LinearGradient(
              colors: [kPrimaryColor, Colors.blue[300]],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      height: size.height,
      width: double.infinity,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/main_top.png",
                width: size.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/main_bottom.png",
                width: size.width * 0.2,
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
