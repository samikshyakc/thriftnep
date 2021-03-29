import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_nep/adminPages/AllProducts/disapprovedWidget.dart';
import 'package:thrift_nep/components/product/product.dart';
import 'package:thrift_nep/provider/disapprovedProduct_provider.dart';

class DisapprovedProducts extends StatelessWidget {
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    productList = Provider.of<DisapprovedProductProvider>(context, listen: true).allDisProduct;
    return Scaffold(
      appBar: AppBar(),
      body: productList.length == 0? Center(child: Text("No new products", style:TextStyle(color: Colors.black),)): SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: productList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return DisapprovedWidget(product: productList[index]);
            }),
      ),
    );
  }
}
