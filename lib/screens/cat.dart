import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thrift_nep/components/cart/cart_screen.dart';
import 'package:thrift_nep/components/horizontal_ListView.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:thrift_nep/provider/cart_provider.dart';
import 'package:thrift_nep/provider/emaiProvider.dart';
import 'package:thrift_nep/provider/product_provider.dart';
import 'package:thrift_nep/widgets/category_widget.dart';
import 'package:thrift_nep/widgets/product_widget.dart';

class Cat extends StatefulWidget {

  final String category;


  Cat(this.category);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Cat> {
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {

    productList = Provider.of<ProductProvider>(context, listen: true).filterByCat(widget.category);
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
                onPressed: () {}),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Categories'),
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
                      return CategroryWidget(product: productList[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
