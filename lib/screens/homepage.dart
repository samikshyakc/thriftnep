import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/components/cart/cart_screen.dart';
import 'package:thrift_nep/components/horizontal_ListView.dart';
import 'package:thrift_nep/components/order/order_screen.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/components/product/sell_product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/orderProvider.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/widgets/product_widget.dart';
import 'package:thrift_nep/screens/user_profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    String email = Provider.of<EmailProvider>(context, listen: false).email();
    String id = Provider.of<EmailProvider>(context, listen: false).id;
    String name = Provider.of<EmailProvider>(context, listen: false).name;
    print("im above cartprovider");
    Provider.of<CartProvider>(context, listen: false).fetchCart(id);
  //  Provider.of<OrderProvider>(context, listen: false).fetchOrder(email);
    print('Email: $email');
    print('ID: $id');

    Widget image_carousel = Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/m2.jpg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: false,
        // animationCurve: Curves.fastOutSlowIn,
        // animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: kPrimaryLightColor,
        dotBgColor: Colors.white30,
        indicatorBgPadding: 4.0,
      ),
    );
    productList = Provider.of<ProductProvider>(context, listen: true).allProduct;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'Thrift Nep',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,

                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'search');
                }),
            IconButton(
                icon: Icon(
                  Icons.shopping_cart_sharp,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => CartProducts()));
                }),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            elevation: 1.5,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '$name',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    '$email',
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: kAppbar,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Home ', style: TextStyle(color: kAppbar)),
                    leading: Icon(Icons.home, color: kAppbar),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()));
                  },
                  child: ListTile(
                    title: Text('My account', style: TextStyle(color: kAppbar)),
                    leading: Icon(Icons.person, color: kAppbar),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrderProducts()));
                  },
                  child: ListTile(
                    title: Text('My Orders ', style: TextStyle(color: kAppbar)),
                    leading: Icon(Icons.shopping_basket_sharp, color: kAppbar),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SellProduct()));
                  },

                  child: ListTile(
                    title:
                        Text('Sell Product', style: TextStyle(color: kAppbar)),
                    leading: Icon(Icons.add_circle_sharp, color: kAppbar),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartProducts()));
                  },
                  child: ListTile(
                    title: Text('My Cart', style: TextStyle(color: kAppbar)),
                    leading: Icon(Icons.shopping_cart_rounded, color: kAppbar),
                  ),
                ),
                Divider(),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // title: Text("Are you sure?"),
                            //content: Text('Logout?'),
                            title:
                                Text('Do you want to exit this application?'),
                            content: Text('We hate to see you leave...'),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('email', "");
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, 'login', (route) => false);
                                },
                                child: Text('YES'),
                              ),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('NO')),
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    title: Text('Logout', style: TextStyle(color: kAppbar)),
                    leading: Icon(
                      Icons.logout,
                      color: kAppbar,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text('About Us', style: TextStyle(color: kAppbar)),
                    leading: Icon(
                      Icons.help,
                      color: kAppbar,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              image_carousel,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Categories'),
              ),
              // Horizontal list view begins here
              HorizontalList(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Recent Products'),
              ),
              //grid-view
              Container(
                child:GridView.builder(
                  shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return ProductWidget(product: productList[index]);
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
