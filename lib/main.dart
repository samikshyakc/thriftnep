import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/AllProducts/disapprovedProducts.dart';
import 'package:thrift_nep/adminPages/AllProducts/productControl.dart';
import 'package:thrift_nep/adminPages/Orders/deliveredOrder.dart';
import 'package:thrift_nep/adminPages/Orders/dispatchedOrder.dart';
import 'package:thrift_nep/adminPages/Users/user_screen.dart';
import 'package:thrift_nep/adminPages/adminSigninScreen.dart';
import 'package:thrift_nep/adminPages/admin_homepage.dart';
import 'package:thrift_nep/adminPages/orderscontrol.dart';
import 'package:thrift_nep/components/cart/checkout.dart';
import 'package:thrift_nep/components/cart/payment.dart';
import 'package:thrift_nep/components/order/confirmed.dart';
import 'package:thrift_nep/components/order/orderHistoryScreen.dart';
import 'package:thrift_nep/components/user_profile/account_screen.dart';
import 'package:thrift_nep/components/user_profile/myProduct.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/DeliveredOrderProvider.dart';
import 'package:thrift_nep/provider/allOrderProvider.dart';
import 'package:thrift_nep/provider/allUserProvider.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/provider/disapprovedProduct_provider.dart';
import 'package:thrift_nep/provider/dispatchedOrderProvider.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/myProductProvider.dart';
import 'package:thrift_nep/provider/orderProvider.dart';
import 'package:thrift_nep/provider/productToVerify.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/screens/homepage.dart';
import 'package:thrift_nep/screens/login_screen.dart';
import 'package:thrift_nep/screens/search.dart';
import 'package:thrift_nep/screens/signup_screen.dart';
import 'package:thrift_nep/screens/splash_screen.dart';
import 'package:thrift_nep/screens/welcome/welcome_screen.dart';
import 'adminPages/AllProducts/adminAllProduct.dart';
import 'adminPages/Orders/allOrder_Screen.dart';
import 'adminPages/ProductVerification/verificationpage.dart';
import 'components/product/product_details.dart';

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
        ),
        ChangeNotifierProvider.value(
          value: CartProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrderProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AllOrderProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DeliveredOrderProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DisptachOrderProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MyProductProvider(),
        ),

        ChangeNotifierProvider.value(
          value: VerifyProductProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AllUserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: DisapprovedProductProvider(),
        ),

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
          'account': (context) => MyAccount(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          'signup': (context) => SignupScreen(),
          'login': (context) => LoginScreen(),
          'home': (context) => HomePage(),
          'welcome': (context) => WelcomeScreen(),
        //  'profile': (context) => ProfileScreen(user: user),
          'prod_details': (context) => ProductDetails(),
          'checkout' : (context) => CheckOut(),
          'payment' : (context) => Payment(),
          'search' : (context) => SearchScreen(null),
          'myProducts' : (context) => MyProducts(),
          'orderHistory' : (context) => OrderHistoryScreen(),
          'confirmOrder' : (context) => OrderPlaced(),
          'admin': (context) => AdminHomeScreen(),
          'adminLogin': (context) => AdminSignUp(),
          'adminUsers': (context) => AllUsers(),
          'verify': (context) => Verification(),
          'adminAllProduct': (context) => AllProduct(),
          'adminAllOrder': (context) => OrderProducts(),
          'deliverOrder': (context) => DeliveredOrder(),
          'dispatchOrder': (context) => DispatchedOrder(),
          'adminOrders': (context) => AdminOrderScreen(),
          'productScreen': (context) => AdminProductScreen(),
          'disapprovedProducts': (context) => DisapprovedProducts(),

        },
      ),
    );
  }
}
