import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/components/user_profile/myProductWidget.dart';
import 'package:thrift_nep/constants/colors.dart';
import 'package:thrift_nep/provider/myProductProvider.dart';
import 'package:thrift_nep/provider/product_provider.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  List<Product> productList = [];
  //int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    productList =
        Provider.of<MyProductProvider>(context, listen: false).myproductList;
   // print(totalPrice);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          //automaticallyImplyLeading: false,
          title: Text(
            'My Products',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kAppbar,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [],
        ),
        body: SingleChildScrollView(
          //crossAxisAlignment: CrossAxisAlignment.start,

          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: productList.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MyProductWidget(productList[index]);
              }),
        ),

      ),
    );
  }
}
