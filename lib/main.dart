import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product_details.dart';
import 'package:thrift_nep/components/product_provider.dart';
import 'package:thrift_nep/components/shopping_cart.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/screens/homepage.dart';
import 'package:thrift_nep/screens/login_screen.dart';
import 'package:thrift_nep/screens/signup_screen.dart';
import 'package:thrift_nep/screens/splash_screen.dart';
import 'package:thrift_nep/screens/welcome/welcome_screen.dart';

// void main() {
//   runApp(MaterialApp(
//     home: WelcomeScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: EmailProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ProductProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'THRIFT NEP',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          primaryColor: kPrimaryLightColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'splash',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          'splash': (context) => SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          'signup': (context) => SignupScreen(),
          'login': (context) => LoginScreen(),
          'home': (context) => HomePage(),
          'welcome': (context) => WelcomeScreen(),
          'prod_details': (context) => ProductDetails(),
          'cart': (context) => Cart(),
        },
      ),
    );
  }
}
