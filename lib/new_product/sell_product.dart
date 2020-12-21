//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/new_product/mens_clothing.dart';

class SellProduct extends StatefulWidget {
  @override
  _SellProductState createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.1, //automaticallyImplyLeading: false,
            title: Text(
              'Sell Products',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: kAppbar,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Container(
            // color: kPrimaryLightColor,
            child: ListView(
              //  title: Text("Choose category of your product"),

              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Choose category of your product",
                      style: TextStyle(color: kPrimaryColor)),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/tshirt.PNG"),
                    ),
                    title: Text("Men's Clothing", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MensClothing()));
                    },
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/dress.PNG"),
                    ),
                    title: Text("Women's Clothing", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/accessories.PNG"),
                    ),
                    title: Text("Accessories", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/heels.PNG"),
                    ),
                    title: Text("Footwears", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/watch.PNG"),
                    ),
                    title: Text("Watchs", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/books.PNG"),
                    ),
                    title: Text("Books", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/pc.PNG"),
                    ),
                    title: Text("PCs", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/mobiles.PNG"),
                    ),
                    title: Text("Mobile phones", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
                Card(
                  shadowColor: kPrimaryColor,
                  child: ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("images/cats/furnitures.PNG"),
                    ),
                    title: Text("Furnitures", style: TextStyle(fontSize: 20)),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

// bottom: TabBar(
//   tabs: [
//     Tab(
//       icon: Icon(Icons.android),
//       text: "Tab 1",
//     ),
//     Tab(icon: Icon(Icons.phone_iphone), text: "Tab 2"),
//     Tab(icon: Icon(Icons.add_sharp), text: "Tab 3"),
//   ],
// ),

// body: TabBarView(
//   children: [
//     Center(child: Text("Page 1")),
//     Center(child: Text("Page 2")),
//     Center(child: Text("Page 2")),
//   ],
// ),
