//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thrift_nep/category/mens_clothing.dart';
import 'package:thrift_nep/components/product/upload_images.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/category/accessories.dart';
import 'package:thrift_nep/category/books.dart';
import 'package:thrift_nep/category/footwears.dart';
import 'package:thrift_nep/category/furnitures.dart';
import 'package:thrift_nep/category/mobile_phones.dart';
import 'package:thrift_nep/category/pcs.dart';
import 'package:thrift_nep/category/watch.dart';
import 'package:thrift_nep/category/womens_clothing.dart';

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
                         // MaterialPageRoute(builder: (context) => MensClothing()));
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Mens Clothing",)));
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
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Womens Clothing",)));
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
                      backgroundImage: AssetImage("images/cats/accessories.PNG"),
                    ),
                    title: Text("Accessories", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Accessories",)));
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
                      backgroundImage: AssetImage("images/cats/heels.PNG"),
                    ),
                    title: Text("Footwears", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Footwears",)));
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
                      backgroundImage: AssetImage("images/cats/watch.PNG"),
                    ),
                    title: Text("Watchs", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Watch",)));
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
                      backgroundImage: AssetImage("images/cats/books.PNG"),
                    ),
                    title: Text("Books", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Books",)));
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
                      backgroundImage: AssetImage("images/cats/pc.PNG"),
                    ),
                    title: Text("PCs", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "PCs",)));
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
                      backgroundImage: AssetImage("images/cats/mobiles.PNG"),
                    ),
                    title: Text("Mobile phones", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Mobile",)));
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
                      backgroundImage: AssetImage("images/cats/furnitures.PNG"),
                    ),
                    title: Text("Furnitures", style: TextStyle(fontSize: 20)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UploadProduct(category: "Furnitures",)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

